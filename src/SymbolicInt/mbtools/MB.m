(* ::Package:: *)
(* MBAnalytica loader for MB.m (M. Czakon; MB tools, gitlab.com/feynmanintegrals/MB).  The file itself is in
   dep/MB unmodified; this loader only finds it, so that every kernel and worker loads the same copy. *)
Get[FileNameJoin[{ParentDirectory[ParentDirectory[ParentDirectory[DirectoryName[ExpandFileName[$InputFileName]]]]],
  "dep", "MB", "MB.m"}]];
