(* Exact endpoint-log extraction for HPL words in {0,1}.  A mixed word
   beginning with zero is regular at BOTH endpoints, including words with
   trailing zeroes.  Only pure-zero words and leading-one strings require
   extraction.  Shuffle identities are memoized by word within each call.
   No endpoint regulator is discarded and no fitted constant is used. *)
rhplLogExtract[expr_] := Module[{extract, argument, words, rules},
  extract[ww_List] := extract[ww] = Module[{nn = Length[ww], rr, tail, shuffles, same},
    Which[
      nn === 0, 1,
      AllTrue[ww, # === 0 &], HPL`HPL[{0}, argument]^nn/nn!,
      AllTrue[ww, # === 1 &], HPL`HPL[{1}, argument]^nn/nn!,
      First[ww] === 0, HPL`HPL[HPL`HPLAtoM[ww], argument],
      True,
        rr = Length[TakeWhile[ww, # === 1 &]]; tail = Drop[ww, rr];
        shuffles = Tally[Table[
          ReplacePart[ConstantArray[1, nn], Thread[Complement[Range[nn], positions] -> tail]],
          {positions, Subsets[Range[nn], {rr}]}]];
        same = Select[shuffles, First[#] === ww &];
        If[same =!= {{ww, 1}}, Return[$Failed, Module]];
        HPL`HPL[{1}, argument]^rr/rr! extract[tail] -
          Total[Last[#] extract[First[#]] & /@ Select[shuffles, First[#] =!= ww &]]]];
  words = DeleteDuplicates[Cases[expr, _HPL`HPL, {0, Infinity}]];
  rules = Table[h -> Module[{ww = HPL`HPLMtoA[First[h]], value},
      If[! ListQ[ww] || ! AllTrue[ww, MemberQ[{0, 1}, #] &], Return[HPL`HPLLogExtract[h], Module]];
      value = extract[ww];
      If[FreeQ[value, $Failed], value /. argument -> Last[h], HPL`HPLLogExtract[h]]], {h, words}];
  expr /. Dispatch[rules]];

Print["[mbeRegularHPLBoundaryRung] exact leading-log shuffle identities for binary HPL words; no endpoint finite parts."];
