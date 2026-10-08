(* MinimalSet10.m -- COMPLETE weight-10 plain (m-notation) minimal set (53169 rules).
   Written 2026-07-14. Replaces the broken shim that installed ZERO of its 53169 rules.
   Association-lookup design: ONE prepended DownValue doing an O(1) hash
   lookup, instead of 53169 SetDelayed rules (which load in O(n^2) and hang).
   The table stays resident -- the rule dereferences it -- so do NOT Clear it. *)
Get[ToFileName[{Global`$HPLPath}, "ms10_rules_v2.mx"]];
Module[{msBefore = DownValues[HPL], msNew},
  HPL[mw_List, t_] := (Global`msRules10[mw] /. Global`HPLP[wd_] :> HPL[wd, t]) /;
     KeyExistsQ[Global`msRules10, mw] &&
     (Not[$HPLAutoProductExpand] || $HPLAutoConvertToKnownFunctions) &&
      $HPLAutoReduceToMinimalSet;
  msNew = Complement[DownValues[HPL], msBefore];
  DownValues[HPL] = Join[msNew, msBefore];
];
