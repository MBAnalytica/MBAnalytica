(* ::Package:: *)

(* mbeFlagGuard.m -- the global switches of the vendored packages survive an interrupted call.

   HPL and HypExp change their automatic-conversion switches by plain global assignment for the duration of an
   internal step and put the old values back at the end of it; HypExp does so for a whole expansion.  A call that is
   interrupted in between (a time limit, a memory limit, an abort) never reaches the line that restores them, and the
   kernel keeps the changed switches for the rest of its life: HPL words are no longer converted or reduced when they
   evaluate, expressions reach the closers in another form, and a term that closes in seconds in a fresh kernel is
   refused.  No value is affected (every value is gated), but a refusal then depends on the history of the kernel.

   Two layers.
   (1) The routines of HypExp that switch are wrapped by their saved definitions: the switches are Block-ed to their
       values at entry, so that every exit, completed or interrupted, leaves them as they were found.  A completed
       call behaves exactly as before, since the package restores its own switches before it returns.
   (2) mbeFlagGuardRestore[tag] puts every guarded switch back to its value at the end of the loader and reports the
       ones it found changed.  The handler, the closing chain and the pool workers call it at the boundaries of their
       units of work (an item, a closing stage, a piece), outside any Block of their own on these switches.
   mbeFlagGuardBlock[body] is the Block of layer (1) for other callers.

   The file may be loaded before HypExp (a worker that loads HypExp on demand): mbeFlagGuardInstall[] is then called
   again by the wrapped loader routine of the core, and the reference values are taken when HypExp has set its own.
   Switches of a package that is not loaded are left alone. *)

Global`$mbeFlagGuardNames = {"$HPLAutoLogExtract", "$HPLAutoConvertToKnownFunctions", "$HPLAutoProductExpand",
   "$HPLAutoReduceToMinimalSet", "$HPLAutoConvertToSimplerArgument", "$HPLAnalyticContinuationSign",
   "$HypExpPolyLogRules", "PLT$AutoConvertToKnownConstants", "PLT$ShuffleRegularisation"};

(* a switch without a value shows up as its own symbol *)
Global`mbeFlagGuardCurrent[] := {HPL`$HPLAutoLogExtract, HPL`$HPLAutoConvertToKnownFunctions, HPL`$HPLAutoProductExpand,
   HPL`$HPLAutoReduceToMinimalSet, HPL`$HPLAutoConvertToSimplerArgument, HPL`$HPLAnalyticContinuationSign,
   HypExp`$HypExpPolyLogRules, PolyLogTools`PLT$AutoConvertToKnownConstants, PolyLogTools`PLT$ShuffleRegularisation};
Global`mbeFlagGuardValueQ[v_] := v === True || v === False || v === 1 || v === -1;

Global`mbeFlagGuardSetOne[k_Integer, v_] := Switch[k,
   1, HPL`$HPLAutoLogExtract = v, 2, HPL`$HPLAutoConvertToKnownFunctions = v, 3, HPL`$HPLAutoProductExpand = v,
   4, HPL`$HPLAutoReduceToMinimalSet = v, 5, HPL`$HPLAutoConvertToSimplerArgument = v,
   6, HPL`$HPLAnalyticContinuationSign = v, 7, HypExp`$HypExpPolyLogRules = v,
   8, PolyLogTools`PLT$AutoConvertToKnownConstants = v, 9, PolyLogTools`PLT$ShuffleRegularisation = v];

(* layer (1): Block to the values at entry, package by package *)
SetAttributes[{Global`mbeFlagGuardBlock, Global`mbeFlagGuardBlockHPL, Global`mbeFlagGuardBlockHypExp,
   Global`mbeFlagGuardBlockPLT}, HoldAll];
Global`mbeFlagGuardBlockHPL[body_] := If[AllTrue[Take[Global`mbeFlagGuardCurrent[], 6], Global`mbeFlagGuardValueQ],
   Block[{HPL`$HPLAutoLogExtract = HPL`$HPLAutoLogExtract,
     HPL`$HPLAutoConvertToKnownFunctions = HPL`$HPLAutoConvertToKnownFunctions,
     HPL`$HPLAutoProductExpand = HPL`$HPLAutoProductExpand,
     HPL`$HPLAutoReduceToMinimalSet = HPL`$HPLAutoReduceToMinimalSet,
     HPL`$HPLAutoConvertToSimplerArgument = HPL`$HPLAutoConvertToSimplerArgument,
     HPL`$HPLAnalyticContinuationSign = HPL`$HPLAnalyticContinuationSign}, body], body];
Global`mbeFlagGuardBlockHypExp[body_] := If[Global`mbeFlagGuardValueQ[HypExp`$HypExpPolyLogRules],
   Block[{HypExp`$HypExpPolyLogRules = HypExp`$HypExpPolyLogRules}, body], body];
Global`mbeFlagGuardBlockPLT[body_] := If[Global`mbeFlagGuardValueQ[PolyLogTools`PLT$AutoConvertToKnownConstants] &&
    Global`mbeFlagGuardValueQ[PolyLogTools`PLT$ShuffleRegularisation],
   Block[{PolyLogTools`PLT$AutoConvertToKnownConstants = PolyLogTools`PLT$AutoConvertToKnownConstants,
     PolyLogTools`PLT$ShuffleRegularisation = PolyLogTools`PLT$ShuffleRegularisation}, body], body];
Global`mbeFlagGuardBlock[body_] :=
  Global`mbeFlagGuardBlockHPL[Global`mbeFlagGuardBlockHypExp[Global`mbeFlagGuardBlockPLT[body]]];

(* layer (2): back to the reference values; True when something had to be restored *)
If[! IntegerQ[Global`$mbeFlagGuardCount], Global`$mbeFlagGuardCount = 0];
Global`mbeFlagGuardRestore[tag_ : ""] := Module[{cur = Global`mbeFlagGuardCurrent[], base = Global`$mbeFlagGuardBaseline, bad},
   If[! ListQ[base] || Length[base] =!= Length[cur], False,
     bad = Select[Range[Length[cur]], Global`mbeFlagGuardValueQ[base[[#]]] && cur[[#]] =!= base[[#]] &];
     If[bad === {}, False,
       Do[Global`mbeFlagGuardSetOne[k, base[[k]]], {k, bad}];
       Global`$mbeFlagGuardCount++;
       Print["[flag-guard] ", If[StringQ[tag] && tag =!= "", tag <> ": ", ""],
         "package switches left changed by an interrupted call, restored: ", Global`$mbeFlagGuardNames[[bad]]];
       True]]];

(* a routine is wrapped once; the wrapper steps aside for the calls made inside it *)
Global`mbeFlagGuardWrap[f_Symbol] := If[DownValues[f] === {} || TrueQ[Global`mbeFlagGuardWrappedQ[f]], False,
   Global`mbeFlagGuardWrappedQ[f] = True;
   With[{prot = MemberQ[Attributes[f], Protected]},
     If[prot, Unprotect[f]];
     DownValues[f] = Prepend[DownValues[f],
       HoldPattern[f[args___]] :> Block[{Global`$mbeFlagGuardInside = True}, Global`mbeFlagGuardBlock[f[args]]] /;
         ! TrueQ[Global`$mbeFlagGuardInside]];
     If[prot, Protect[f]]];
   True];

(* wraps what is loaded; takes the reference values the first time, and again when HypExp has just been loaded
   (its loading sets two HPL switches).  Safe to call any number of times. *)
Global`mbeFlagGuardInstall[] := Module[{new = {}},
   If[MemberQ[$Packages, "HypExp`"],
     new = Select[Global`mbeFlagGuardWrap /@ {HypExp`HypExp, HypExp`HypExpInt, HypExp`Private`HaHypExpAlg,
         HypExp`Private`MyHypExpansion2, HypExp`Private`HaHypExpAtOneNonCrit, HypExp`Private`Tobias}, TrueQ]];
   If[! ListQ[Global`$mbeFlagGuardBaseline] || new =!= {}, Global`$mbeFlagGuardBaseline = Global`mbeFlagGuardCurrent[]];
   Global`$mbeFlagGuardInstalled = True;
   Length[new]];

(* the core loads HypExp on demand through this routine; afterwards the guard completes its installation *)
If[DownValues[MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp] =!= {} && ! TrueQ[Global`$mbeFlagGuardEnsureWrapped],
  Global`$mbeFlagGuardEnsureWrapped = True;
  DownValues[MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp] = Prepend[DownValues[MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp],
    HoldPattern[MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp[]] :>
      Block[{Global`$mbeFlagGuardEnsureInside = True},
        With[{r = MBAnalytica`SymbolicInt`Private`mbeEnsureHypExp[]}, Global`mbeFlagGuardInstall[]; r]] /;
        ! TrueQ[Global`$mbeFlagGuardEnsureInside]]];

With[{n = Global`mbeFlagGuardInstall[]},
  If[! TrueQ[Global`$mbeFlagGuardQuiet],
    Print["[mbeFlagGuard] package switches guarded against interrupted calls (",
      Count[Global`$mbeFlagGuardBaseline, _?(Global`mbeFlagGuardValueQ)], " switches; ", n, " HypExp routines wrapped",
      If[MemberQ[$Packages, "HypExp`"], "", "; HypExp not loaded yet"], ")."]]];
