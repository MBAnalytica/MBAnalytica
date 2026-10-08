(* MinimalSet9.m -- COMPLETE weight-9 plain (m-notation) minimal set (17499 rules).
   Written 2026-07-14. Replaces the TRUNCATED text file, which held only 3400 of 17499 rules.
   Association-lookup design: ONE prepended DownValue doing an O(1) hash
   lookup, instead of 17499 SetDelayed rules (which load in O(n^2) and hang).
   The table stays resident -- the rule dereferences it -- so do NOT Clear it. *)
Get[ToFileName[{Global`$HPLPath}, "ms9_rules.mx"]];
Module[{msBefore = DownValues[HPL], msNew},
  HPL[mw_List, t_] := (Global`msRules9[mw] /. Global`HPLP[wd_] :> HPL[wd, t]) /;
     KeyExistsQ[Global`msRules9, mw] &&
     (Not[$HPLAutoProductExpand] || $HPLAutoConvertToKnownFunctions) &&
      $HPLAutoReduceToMinimalSet;
  msNew = Complement[DownValues[HPL], msBefore];
  DownValues[HPL] = Join[msNew, msBefore];
];
