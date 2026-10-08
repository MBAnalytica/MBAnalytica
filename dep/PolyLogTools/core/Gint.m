(* ::Package:: *)

(**************************************************************************)
(*  This package contains the routines to integrate harmonis polylogs     *)
(**************************************************************************)


ApplyGint[expr_, t_, x_] := Block[{te = 0, te1= Expand[expr], nblocks, rest},
    nblocks =  IntegerPart[Length[te1]/100];
    If[nblocks > 1,
       Do[ te += Gint[Take[te1, 100], t, x];
       te1 = Drop[te1, 100],
       {nblocks}]];
    te += Gint[te1, t, x]]; 
    
    


(*Instruction to kill this routine*)

nointrules := Clear[Gint];

(*Linearity of the integral*)

Gint[c_ f_, t_, x_] := c Gint[f, t, x] /; FreeQ[c, t];
Gint[f1_ + f2_, t_, x_] := Gint[f1, t, x] + Gint[f2, t, x];

(*Basic integrals, solved by series expansion*)

Gint[t_^n1_.(u_ + v_.*t_)^n2_., t_, x_] := Gint[Expand[Apart[t^n1 (u + v*t)^n2, t]], t, x] /; FreeQ[{u, v}, t];


Gint[t_^n1_.(u_.*t_ + v_ + w_.*t_)^n2_., t_, x_] := Gint[Expand[Apart[t^n1 (u*t + v + w*t)^n2, t]], t, x] /; FreeQ[{u,  w}, t];

Gint[(u_ + v_.*t_)^n1_.(w_ + y_.*t_)^n2_., t_, x_] := Gint[Expand[Apart[(u + v*t)^n1 (w + y*t)^n2, t]], t, x] /; FreeQ[{u, v, w, y}, t];

Gint[(u_.*t_ + v_ + w_.*t_)^n1_.(y_ + s_.*t_)^n2_., t_, x_] := Gint[Expand[Apart[(u*t + v + w*t)^n1 (y + s*t)^n2, t]], t, x] /; FreeQ[{u,  w, y, s}, t];

Gint[(u_.*t_ + v_ + w_.*t_)^n1_.(y_.*t_ + s_. + p_.*t_)^n2_., t_, x_] := Gint[Expand[Apart[(u*t + v + w*t)^n1 (y t + s + p*t)^n2, t]], t, x] /; FreeQ[{u,  w, y, s, p}, t];

Gint[t_^n1_.(u_ + v_.*t_)^n2_. f_., t_, x_] := Gint[Expand[Apart[t^n1 (u + v*t)^n2, t]f], t, x] /; FreeQ[{u, v}, t];

Gint[t_^n1_.(u_.*t_ + v_ + w_.* t_)^n2_. f_., t_, x_] := Gint[Expand[Apart[t^n1 (u*t + v + w*t)^n2, t]f], t, x] /; FreeQ[{u,  w}, t];

Gint[(u_ + v_.*t_)^n1_.(w_ + y_.*t_)^n2_. f_., t_, x_] := Gint[Expand[Apart[(u + v*t)^n1 (w + y*t)^n2, t]f], t, x] /; FreeQ[{u, v, w, y}, t];

Gint[(u_.*t_ + v_ + w_.*t_)^n1_.(y_ + s_.*t_)^n2_. f_., t_, x_] := Gint[Expand[Apart[(u*t + v + w*t)^n1 (y + s*t)^n2, t]f], t, x] /; FreeQ[{u,  w, y, s}, t];

Gint[(u_.*t_ + v_ + w_.*t_)^n1_.(y_.*t_ + s_. + p_.*t_)^n2_. f_., t_, x_] := Gint[Expand[Apart[(u*t + v + w*t)^n1 (y*t + s + p*t)^n2, t]f], t, x] /; FreeQ[{u,  w, y, s, p}, t];

(*Basic integrals, definitions of simplest harmonic polylogs and their 2 - dimensional extension*)

Gint[c_, t_, x_] := c x /; FreeQ[c, t];

Gint[t_^n_., t_, x_] := 1/(n + 1) x^(n + 1) /; n != -1;
Gint[(u_ + t_)^n_., t_, x_] := 1/(n + 1) ((u + x)^(n + 1) ) /; (n != -1) && FreeQ[u, t];
Gint[(u_ + v_*t_)^n_., t_, x_] := 1/(n + 1)/v ((u + v*x)^(n + 1)) /; (n != -1) && FreeQ[{u, v}, t];
Gint[(u_.*t_ + v_ + w_. t_)^n_., t_, x_] := Gint[((u + w)*t + v)^n,t,x] /; (n != -1) && FreeQ[{u, v, w}, t];


Gint[1/(b_. t_  + a_.), t_ ,x_] := G[-a/b, x]/b /; FreeQ[{a,b},t];

Gint[(b_. t_ + c_. t_ + a_.)^n_., t_ ,x_] := Gint[((b+c)t + a)^n, t, x] /; FreeQ[{b,c},t];

Gint[G[ws___, t_]/(b_. t_+a_.), t_, x_] := G[-a/b, ws, x]/b /; FreeQ[{a, b},t];

Gint[G[ws___, t_](b_. t_+ c_. t_+a_.)^n_., t_, x_] := Gint[G[ws,t]((b+c)t + a)^n, t, x] /; FreeQ[{b,c},t];






G[_] := 1;

(*Integration by parts rules for polylogs*)

Gint[t_^n_. G[u_, v___, t_], t_, x_] := 1/(n + 1) x^(n + 1) G[u, v, x]  - Gint[Expand[Apart[1/(n + 1) t^(n + 1) * G[v, t]/(t-u), t]], t, x] /; n != -1;

Gint[(g_. + h_.*t_)^n_. G[u_, v___, t_], t_, x_] := 1/(n + 1)/h (g + h*x)^(n + 1) G[u, v, x]  - Gint[Expand[Apart[1/(n + 1)/h (g + h*t)^(n + 1) * G[v, t]/(t-u), t]], t, x] /; (n != -1) &&FreeQ[{g, h}, t];

Gint[G[u_, v___, t_], t_, x_] := x G[u, v, x] - Gint[Expand[Apart[t/(t-u)*G[v, t],t]], t, x];






(* ::Subsection:: *)
(**)


(* ::Section:: *)
(*The complex basis*)


Gint[1/(t_^2 + a_), t_, x_] := Gint[Expand[1/(t-Sqrt[-a])- 1/(t+Sqrt[-a])], t, x]/2/a /; FreeQ[a,t];

Gint[G[ws__, t_]/(t_^2 + a_), t_, x_] := Gint[Expand[G[ws,t](1/(t-Sqrt[-a])- 1/(t+Sqrt[-a]))], t, x]/2/a /; FreeQ[a,t];





(* ::Section:: *)
(*Specials*)


(*Gint[a_. * (ub[3] v^2 + (u[1] - u[2] - ub[3])v+ u[2] - u[2]u[1])^n_., v, vmax_] := Gint[Expand[Apart[a ub[3]^n (v-u[1,2,3])^n(v-ub[1,2,3])^n,v]], v, vmax];

Gint[a_. * (ub[3] v^2 + u[1] v - u[2] v - ub[3]v+ u[2] - u[2]u[1])^n_., v, vmax_] := Gint[Expand[Apart[a ub[3]^n (v-u[1,2,3])^n(v-ub[1,2,3])^n,v]], v, vmax];*)

Gint[a_. / (v1 u[1](v1 u[3]-1)-(v1-1)(u[2]+v1 u[3]-1)), v1, vmax_] := Gint[Expand[Apart[a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (-v1^2 u[3](u[1]-1)+v1 (u[1]+u[2]-u[3]-1) - u[2]+1), v1, vmax_] := Gint[Expand[Apart[-a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (v1^2 u[3]u[1]-v1^2 u[3]-v1 (u[1]+u[2]-u[3]-1) + u[2]-1), v1, vmax_] := Gint[Expand[Apart[a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (v1^2 u[3]u[1]-v1^2 u[3]+v1 (-u[1]-u[2]+u[3]+1) + u[2]-1), v1, vmax_] := Gint[Expand[Apart[a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (v1^2 u[3](u[1]-1)-v1 (u[1]+u[2]-u[3]-1) + u[2]-1), v1, vmax_] := Gint[Expand[Apart[a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (v1^2 u[3]u[1]-v1^2 u[3]-v1 u[1]-v1 u[2]+v1 u[3]+v1 + u[2]-1), v1, vmax_] := Gint[Expand[Apart[a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];
Gint[a_. / (-v1^2 u[3]u[1]+v1^2 u[3]+v1 u[1]+v1 u[2]-v1 u[3]-v1 - u[2]+1), v1, vmax_] := Gint[Expand[Apart[-a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];

Gint[a_. / (-v1^2 u[3](u[1]-1)+v1 (u[1]+u[2]-u[3]-1) - u[2]+1), v1, vmax_] := Gint[Expand[Apart[-a /(u[3] (u[1]-1)(v1-u[1,2,3])(v1-ub[1,2,3])),v]], v1, vmax];


Gint[c_. * (ub[3] v^2 + u[1] v - u[2] v  - u[2]u[1])^n_., v, vmax_] := Gint[Expand[Apart[c ub[3]^n (v-a[1,2,3])^n(v-ab[1,2,3])^n,v]], v, vmax];

Gint[c_. * (ub[3] v^2 + (u[1]  - u[2]) v  - u[2]u[1])^n_., v, vmax_] := Gint[Expand[Apart[c ub[3]^n (v-a[1,2,3])^n(v-ab[1,2,3])^n,v]], v, vmax];


(* ::Section:: *)
(*Other integration limits*)


Gint[expr_, t_, tmin_, tmax_] := Gint[expr, t, tmax] - Gint[expr, t, tmin];
