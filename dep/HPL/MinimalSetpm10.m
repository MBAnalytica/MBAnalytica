(* MinimalSetpm10.m -- COMPLETE weight-10 pm (plus/minus) minimal set (53169 rules).
   Written 2026-07-14. This set never existed before.
   Association-lookup design: ONE prepended DownValue doing an O(1) hash
   lookup, instead of 53169 SetDelayed rules (which load in O(n^2) and hang).
   The table stays resident -- the rule dereferences it -- so do NOT Clear it. *)
Get[ToFileName[{Global`$HPLPath}, "mspm10_rules.mx"]];
Module[{msBefore = DownValues[HPL], msNew},
  HPL[mw_List, t_] := (Global`msPmRules10[mw] /. Global`HPLP[wd_] :> HPL[wd, t]) /;
     KeyExistsQ[Global`msPmRules10, mw] &&
     (Not[$HPLAutoProductExpand] || $HPLAutoConvertToKnownFunctions) &&
      $HPLAutoReduceToMinimalSet;
  msNew = Complement[DownValues[HPL], msBefore];
  DownValues[HPL] = Join[msNew, msBefore];
];
