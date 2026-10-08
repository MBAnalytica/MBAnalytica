(* ReduceCG78: the weight-7..10 branch of the ReduceCG dispatcher (Reduction.m).
   Fail-closed identity: no boundary-constant table is shipped with this release, so a G of weight 7..10 with
   letters in {0,1,-1} at argument +-1 is retained as the exact GPL itself, exactly as ReduceCG6 does for weight 6.
   Reduction is optional; the route's exactness does not depend on it (no file of the route calls ReduceCG).
   2026-09-10 (MB_standard release R2): the earlier version of this file looked up an external table directory
   that is not part of the release; the lookup was never reached by any run and is removed. *)
ReduceCG78[g_G, variables_List, OptionsPattern[ReduceCG]] := g;
