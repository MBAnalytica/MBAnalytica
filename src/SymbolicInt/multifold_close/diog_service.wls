(* diog_service.wls (1 October 2026) -- DIOGENES as a SPOOL SERVICE in its own main kernel (no Parallel subkernel: the
   subkernel pool is shared with the piece workers and the Standard regression, and a failed launch under the license ceiling
   left the fallback dead or crashed the caller).
     usage: WolframKernel -noinit -noprompt -script diog_service.wls <spool directory> [DIOGENES directory]
   Protocol (plain files, InputForm strings, Global` symbols diogEps and diogZZ):
     request  <spool>/req_<id>.m   = {"PFQ" -> "<InputForm of HypergeometricPFQ[num, den, diogZZ] in diogEps>", "Depth" -> n, "Budget" -> s}
     response <spool>/res_<id>.m   = {"Result" -> "<InputForm of Normal[ExpandHypergeometry]>" | "$Failed", "Seconds" -> t}
   The request is deleted once the response is written.  A heartbeat <spool>/service_alive.txt carries the last poll time.
   DIOGENES (M. A. Bezuglov, A. I. Onishchenko, arXiv:2312.06242; GPL-3.0) is loaded from the directory given, else from
   $MBStandardDiogenesPath, else from <this file's package root>/vendor/DIOGENES. *)
(* arguments: under "WolframKernel -script file args" $ScriptCommandLine can be empty; read them after the script name in
   $CommandLine *)
svcArgs = Module[{cl = $CommandLine, p}, p = Position[cl, s_String /; StringEndsQ[s, "diog_service.wls"]];
  If[p === {}, If[Length[$ScriptCommandLine] >= 1, Rest[$ScriptCommandLine], {}], Drop[cl, p[[1, 1]]]]];
svcSelf = Module[{cl = $CommandLine, p}, p = Position[cl, s_String /; StringEndsQ[s, "diog_service.wls"]]; If[p === {}, "", cl[[p[[1, 1]]]]]];
spool = If[Length[svcArgs] >= 1, svcArgs[[1]], FileNameJoin[{$TemporaryDirectory, "diog_spool"}]];
diogDir = Which[Length[svcArgs] >= 2, svcArgs[[2]],
  StringQ[Global`$MBStandardDiogenesPath], Global`$MBStandardDiogenesPath,
  svcSelf =!= "", FileNameJoin[{ParentDirectory[ParentDirectory[ParentDirectory[DirectoryName[ExpandFileName[svcSelf]]]]], "dep", "DIOGENES"}],
  True, "."];
Quiet@CreateDirectory[spool, CreateIntermediateDirectories -> True];
Print["[diog_service] spool ", spool, "; DIOGENES ", diogDir, " (", If[DirectoryQ[diogDir], "found", "MISSING"], ")"];
If[!FileExistsQ[FileNameJoin[{diogDir, "DIOGENES.wl"}]], Print["[diog_service] DIOGENES.wl not found; exiting"]; Exit[1]];
SetDirectory[diogDir]; Quiet[Get["DIOGENES.wl"]]; SetDirectory[spool];
Print["[diog_service] DIOGENES loaded; serving (pid ", $ProcessID, ")"];
Export["service_alive.txt", "pid " <> ToString[$ProcessID] <> " started " <> DateString[], "Text"];
nServed = 0;
While[True,
  Module[{reqs = Sort[FileNames["req_*.m", spool]]},
    If[reqs === {}, Pause[0.5]; If[Mod[Round[AbsoluteTime[]], 30] == 0, Quiet@Export["service_alive.txt", "pid " <> ToString[$ProcessID] <> " alive " <> DateString[] <> " served " <> ToString[nServed], "Text"]],
      Do[Module[{id = StringReplace[FileNameTake[r], {"req_" -> "", ".m" -> ""}], rq, pfq, depth, budget, t0 = AbsoluteTime[], res, out},
          rq = Quiet@Check[Get[r], $Failed];
          If[!ListQ[rq], Quiet@DeleteFile[r]; Continue[]];
          pfq = Quiet@ToExpression[Lookup[rq, "PFQ", "$Failed"], InputForm];
          depth = Lookup[rq, "Depth", 1]; budget = Lookup[rq, "Budget", 600];
          res = If[Head[pfq] === HypergeometricPFQ,
            Quiet@TimeConstrained[Normal[DIOGENES`ExpandHypergeometry[pfq, Global`diogEps, depth]], budget, $Failed], $Failed];
          (* full symbol contexts in the string (DIOGENES`G, Global`diogZZ): the client must not resolve bare names on its
             own context path *)
          out = {"Result" -> If[res === $Failed || !FreeQ[res, $Aborted], "$Failed", Block[{$ContextPath = {"System`"}}, ToString[res, InputForm]]], "Seconds" -> AbsoluteTime[] - t0};
          Put[out, FileNameJoin[{spool, "res_" <> id <> ".m.tmp"}]];
          (* atomic: the client polls for res_<id>.m *)
          Quiet@RenameFile[FileNameJoin[{spool, "res_" <> id <> ".m.tmp"}], FileNameJoin[{spool, "res_" <> id <> ".m"}]];
          Quiet@DeleteFile[r]; nServed++;
          Print["[diog_service] ", id, ": ", If[out[[1, 2]] === "$Failed", "FAILED", "expanded"], " in ", Round[AbsoluteTime[] - t0], " s (depth ", depth, ")"]],
        {r, reqs}]]]];
