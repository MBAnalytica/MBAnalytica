(* AUTHORSHIP (release R2, 2026-09-07): component of the MB2MPL package (Standard route). Authors of MB2MPL: Syed Mehedi Hasan, Taushif Ahmed, Andreas Rapakoulias, Sumit Banik. *)
(* load_mbe_engines.m — loads the theory-guided strategy engines for the standard route.
   Get this AFTER load_standard.m (or any loader that provides MB2MPL.m + PolyLogTools).
   Provides: HyperIntica (hyperlogarithm words), hf_machinery (cubeHF subprocess integrator + gvN/gvExact),
   engineN_lib plus engineN_grouped_lib (faithful fused and pre-Together scale-class producers),
   mbe_strategy_dispatch_v2 (MBEStrategy`mbeStdClassify / mbeStdClose — the normalise->classify->dispatch layer
   of standard_syed.tex sec:coverage).  All Gets are guarded so a partial environment degrades loudly, not
   silently.  See ENGINE_HANDOFF.md for the method record. *)
Module[{dir = DirectoryName[$InputFileName /. "" -> FileNameJoin[{Directory[], "load_mbe_engines.m"}]],
    hyperIntica},
  If[dir === "", dir = Directory[]];
  SetDirectory[dir];
  If[!MemberQ[$Packages, "MBtoMPL`"],
    Print["[load_mbe_engines] WARNING: MBtoMPL (MB2MPL.m) not loaded; load load_standard.m first."]];
  If[Names["HyperIntica`ZeroInfPeriodAsMpl"] === {},
    hyperIntica = FileNameJoin[{Global`$HyperInticaPath, "HyperIntica.wl"}];
    Quiet@Get[hyperIntica];
    If[Names["HyperIntica`ZeroInfPeriodAsMpl"] =!= {}, HyperIntica`$QuietPrint = True,
      Print["[load_mbe_engines] WARNING: HyperIntica failed to load; cubeHF word evaluation unavailable."]]];
  Get[FileNameJoin[{dir, "hf_machinery.m"}]];
  Get[FileNameJoin[{dir, "engineN_lib.m"}]];
  Get[FileNameJoin[{dir, "engineN_grouped_lib.m"}]];
  Get[FileNameJoin[{dir, "mbe_strategy_dispatch_v2.m"}]];
  Print["[load_mbe_engines] engines loaded: cubeHF=", Head[DownValues[Global`cubeHF]] === List && DownValues[Global`cubeHF] =!= {},
    " engineN=", DownValues[Global`engineNSubcubes] =!= {},
    " grouped=", DownValues[Global`engineNGroupedSubcubes] =!= {},
    " dispatch=", DownValues[MBEStrategy`mbeStdClassify] =!= {}];
];
