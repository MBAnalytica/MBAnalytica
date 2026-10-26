# MB_standard — release R3.2: Standard route, external parameters, and every benchmark integral on the Subtraction route

Exact evaluation of dimensionally regulated Mellin–Barnes (MB) integrals: the ε-expansion of an MB integrand is
returned as an exact Laurent series whose coefficients are multiple polylogarithms and multiple zeta values.  The
computation is the **Standard route** of MBSymbolicInt — resolution of the contour pinches (MBresolve), ε-expansion,
Barnes reduction, and the exact closure of every ε-free Barnes piece by the sealed core and its class-handler rungs.

The calculation uses **no pre-computed answer library**: no certified piece library, no phase-block record, no
IntVol knowledge library. Every value is derived analytically at run time, and every value served is exact (no
floating-point number is ever returned as a result; a piece the route cannot close makes the run fail closed).
The separately supplied `mbu_results.m` records the completed MB1u–MB14u answers for sharing and inspection;
the calculation does not load it.

**Benchmark status at a glance:** `benchmark_status.pdf` — the coloured status chart of both routes (every verified ε
order of every integral, with the regression times); `regression_test.pdf` — the full regression record.

## Authors and acknowledgements

- **MBSymbolicInt** (the package: `MBSymbolicInt.wl`, the rungs `mbe*.m`, the engines, the worker, the notebook): Taushif Ahmed,
  Sumit Banik, Syed Mehedi Hasan, Andreas Rapakoulias.
- **IntVol** (`IntVol_stable.m`, `IntVol_BigExpr_Helpers.m`, `intvol_*_prototype.m`), the Euler-integral backend, and
  **IntVolFLINT** (`intvolflint/`, `hf_machinery.m`, `vendor/IntVolFLINT`), the certified-order hyperlogarithm strategy:
  Syed Mehedi Hasan.
- IntVolFLINT runs on two backends by other authors, acknowledged wherever they are used: the hyperlogarithm integrator
  **HyperFLINT** (`vendor/IntVolFLINT` is a fork of HyperFLINT 1.2.13) and the word evaluator **HyperIntica**, both from
  SubTropica by M. Giroux, S. Mizera and G. Salvatori (arXiv:2604.20954); HyperIntica is a native Mathematica
  reimplementation of E. Panzer's HyperInt (arXiv:1403.3385).
- Vendored packages: PolyLogTools (C. Duhr, F. Dulat), HPL (D. Maitre), HypExp (T. Huber, D. Maitre), the
  Henn–Smirnov–Smirnov sixth-root tables; `MB.m` (M. Czakon) and `MBresolve.m` (A. V. Smirnov, V. A. Smirnov).  See
  `THIRD_PARTY_NOTICES.md`.  (HarmonicSums was removed on 2026-09-08: no rung uses it, and the sealed core's optional
  HarmonicSums closer, which never served a value on the benchmark corpus, is disabled by the loader.)

## Prerequisites

- Wolfram Mathematica (developed and tested with 14.2).  The Barnes pieces are closed by parallel subkernels launched
  from the notebook kernel.  `$MBSerialPieceKernels` is the maximum number of workers: `Automatic` (the default
  everywhere: notebooks, `run_standard.m`, `run_regression.wls`) is the resource policy — half of the subkernels of a
  large licence (`$MaxLicenseSubprocesses` ≥ 32, e.g. 124 of 248), every subkernel of a small licence (a laptop),
  never more than the cores of the machine, and shared with your other running jobs (a census of the running
  subkernels); an integer is your own maximum.  The launcher starts the smaller of the request, the licence allowance,
  the cores, the remaining budget and the piece count, always at least one worker, prints the number, and scales the
  hyperlogarithm integrator to the worker count (threads per `hyperflint` process, candidate integration orders raced
  at once, per-candidate budget) so that the whole node is used without being oversubscribed.
  `$MBSerialWorkerMode = "Processes"` uses separate `math` kernels instead (one main-kernel licence seat each; `math`
  must be on the PATH).  Strictly serial evaluation (`$MBSerialPieceKernels = 0`) is possible but far slower and never
  the default; if no worker of either kind can start, the run prints a warning and continues serially.  On a cluster
  use `run_standard.m` (below).
- GiNaC with CLN, including the `ginsh` shell on `PATH` (used by PolyLogTools for numerics; a C++ toolchain is
  needed to install GiNaC).  If `ginsh` is not on the PATH of the kernel, set
  `$MBStandardGinshExecutable = "/absolute/path/to/ginsh"` before loading (the notebooks' initialization cells show
  the line).
- The hyperlogarithm integrator binary `vendor/IntVolFLINT/bin/hyperflint` (Linux x86-64, links against libgmp,
  libmpfr, libgomp, libstdc++).  If it does not run on your machine, rebuild it from `vendor/IntVolFLINT/src`
  (C++17, CMake, FLINT, GMP, MPFR): see `vendor/IntVolFLINT/BUILD.md`, and either place the executable there or set
  `$MBStandardHyperFLINTBinary = "/absolute/path/to/hyperflint"` before loading.  `configure_runtime.m` checks it at
  load.
- Python 3 with SymPy, NumPy and SciPy (`parameter_support/requirements.txt`).  The u-dependent Subtraction route
  runs its native coefficient jobs through Python and certifies each record by an exact comparison (SymPy) with its rerun
  under algebraic letters; without SymPy no record that differs only in form can be certified, and the route sends far
  more jobs to the exact last fold or refuses.  NumPy and SciPy serve independent contour diagnostics of
  parameter-dependent candidates; numerical diagnostics never supply coefficients.  Install a package-local environment
  with `python3 -m venv .venv` and `.venv/bin/pip install -r parameter_support/requirements.txt` (where `ensurepip` is
  missing: `python3 -m venv --without-pip .venv` and `python3 -m pip --python .venv/bin/python3 install -r
  parameter_support/requirements.txt`).  The loader uses, in this order, `$MBStandardPythonExecutable` if it is set
  before loading, the package-local `.venv/bin/python3`, and `python3` on the PATH, and prints a warning when that
  Python cannot import SymPy, NumPy and SciPy.
- The Linux `prlimit` and `timeout` commands are used by the parameter route's native launcher. It retains the
  enlarged stack setting used in the successful research calculations.
- The folder must be writable (`.cache/`, `standard_serial_results/`, `worker_logs/`).  Everything else is located
  relative to the folder (the notebooks load their source relative to `NotebookDirectory[]`); nothing in the package
  needs editing.

Everything else is bundled under `vendor/`: PolyLogTools 1.4 (with the weight-7/8 multiple-zeta-value tables
`core/MZVw78.m` and the sixth-root-of-unity module; its weight 7–10 boundary-value branch `core/ReduceCG78.m` needed
DIOGENES tables that are not shipped, is reached by no route, and is a fail-closed identity), HPL 2.0 (with the
weight-9 and weight-10 tables, minimal-set rules and constants), HypExp 2.0 (with the expansion rules to weight 10),
HyperIntica.  The sixth-root tables of `level6_tables/` cover weights 1–4.

## Start here: the notebook

Open `MBSymbolicInt_StandardRoute.nb` and evaluate its initialization cell.  It binds the bundled packages, loads the sealed
core and the rungs, and defines the notebook functions.  Then:

- **One benchmark integral.**  Each section (MB1–MB14, with MB8 = MB8a + MB8b and MB14 = MB14a + MB14b; then the
  pilot integrals MBpilot12 and MBpilot13)
  shows the available benchmark coefficients, lets you edit the ε range, runs the integral, and shows the per-order
  comparison: the exact raw coefficient, its physical real part, the benchmark, the relative error, and the exact
  canonical match (the difference expanded over the prime factorisation of every logarithm is literally zero).
- **Every target.**  `MBSerialRunAll[]` runs every target at its verified range; `MBSerialSummary[]` prints
  seconds, pass, exact match and failed pieces per target.
- **Your own integral.**  `MBStandardEvaluate[integrand, orderMin, orderMax]` returns the exact coefficients of any
  MB integrand written as in `mb_targets_all.m` (Gamma functions with affine arguments in the integration variables,
  the regulator ε, an optional exponential prefactor; MBresolve determines the contours).  Write or load the
  integrand *after* the initialization cell, with the regulator typed as ε (`\[Epsilon]`): after the load that name
  resolves to the symbol the bundled targets use (PolyLogTools exports a symbol of that name).  An integrand defined
  before the load, or with the regulator written as `Global`\[Epsilon]`, carries a different symbol of the same
  appearance; `MBStandardEvaluate` refuses it with a message rather than returning an empty series.

For a plain Wolfram Language session:

```mathematica
Get["/path/to/MB_standard/load_standard.m"];
MBAnalytica`SymbolicInt`MBresolveToMPL[integrand, \[Epsilon], "EpsOrderMin" -> -3, "EpsOrderMax" -> 0,
  "Route" -> "Standard", "PieceKernels" -> 10]
```

The result is the exact raw complex Laurent series (the physical value of a real integral is its real part; the
imaginary part is the raw contour phase and is retained).  `MBAnalytica`SymbolicInt`Private`$mbtFailedPieces` is the ledger of pieces
the route refused; a non-empty ledger means the run is incomplete, never that a zero was substituted.  The second
argument must be the regulator symbol that appears in the integrand: type both as ε after the load (see the note on
the regulator above); the direct call has no guard and returns an empty series for a mismatched symbol.

## External parameter examples: MB1u–MB14u

The notebook's **Differential examples** section runs the supplied integrands with `u` left external, through the
inclusive benchmark's highest order minus four. `MBStandardULedger[]` lists the ranges;
`MBStandardUInput["MB8u"]`, for example, returns the sum of its two supplied components (likewise MB2u and MB14u).
The example file `mb_u_targets.m` contains input integrands only; its `TimeConstraints` entry gives MB14u a longer
time budget than the default.

```mathematica
Clear[Global`u];
MBStandardULedger[]
answer = MBStandardRunU["MB1u"];  (* epsilon^-3 through epsilon^1 *)
answer["Coefficients"]
(* Any supported exact input, with its actual regulator symbol: *)
MBStandardEvaluate[integrand, -3, 1,
  "Regulator" -> ep, "ExternalParameters" -> {Global`u},
  "ParameterAssumptions" -> 0 < Global`u < 1,
  "ParameterTimeConstraint" -> 900]
```

| Examples | Requested epsilon powers |
|---|---|
| MB1u | -3 through 1 |
| MB2u | -2 through 0 |
| MB3u | -4 through 0 |
| MB4u, MB5u | -6 through -3 |
| MB6u | -5 through -2 |
| MB7u | -5 through -1 |
| MB8u–MB11u | -6 through -3 |
| MB12u | -5 through -1 |
| MB13u, MB14u | -6 through -3 |

The same families run on the **Subtraction route** with `MBSubtractionRunU` (the ranges of `MBSubtractionULedger[]`,
the orders each family had been computed to before):

```mathematica
Clear[Global`u];
MBSubtractionULedger[]
answer = MBSubtractionRunU["MB6u"];  (* epsilon^-5 through epsilon^1 on the Subtraction route *)
```

| Examples (Subtraction route) | Epsilon powers |
|---|---|
| MB1u | -3 through 4 |
| MB2u | -2 through 3 |
| MB3u | -4 through 3 |
| MB4u, MB5u, MB9u, MB10u, MB11u | -6 through 0 |
| MB6u | -5 through 1 |
| MB7u | -5 through 2 |
| MB8u, MB13u, MB14u | -6 through -3 |
| MB12u | -5 through -1 |

### Saved answers for sharing

`mbu_results.m` contains the 14 completed Standard-route results and their 59 exact coefficient functions at the
ranges above. It is a standalone symbolic record, copied from the corresponding research records without changing
the expressions. To inspect it without rerunning the integrals:

```mathematica
Clear[Global`u, Global`\[Epsilon]];
Get["/path/to/MB_standard/mbu_results.m"];
MB13uVal
MBuResults["MB13u"]["Coefficients"]
```

The aliases `MB1uVal` through `MB14uVal` contain the Laurent polynomials; each association also records its order
range, remainder order, domain, and validation provenance. HPL/GPL symbols retain their explicit package contexts.
Numerical evaluation of those functions requires HPL/PolyLogTools, bundled in this folder. The `Source` and
`Derivation` paths identify research records relative to the research tree; loading the answers does not need those files.

The result retains the complex phase and exact GPL/HPL coefficients. The open domain `0 < u < 1` supplies the
positive-base branch of every Mellin power. Evaluate `u = 1` by a separate left limit of the result; some
coefficients diverge there. Substituting that endpoint in the input is not an ordinary pointwise Barnes integral.
The parameter route currently runs serially. Whole-integral answers are not read from the inclusive notebook
checkpoints. The bundled HypExp calculates the required hypergeometric expansions directly; the optional
development cache is not a release dependency.

The class rungs cover scaled Gamma pairs and balanced four-Gamma kernels, transverse Barnes reductions with
crossed residues, coupled Euler cubes, and two-scale six-Gamma conic classes. External parameters belong to the
positive kinematic bases and prefactors; a parameter inside a Gamma argument is outside the present contract.
Every coefficient must close exactly. Unsupported structure, an incomplete numerical diagnostic, or a timeout
returns `Failure` for the complete request. Inspect ``MBParameter`$LastParameterRun`` for its source and diagnostics.
Contours near a pole may be moved within their exact pole chamber only after a strict decay certificate
and all wall inequalities pass; the diagnostic record includes both contours and that certificate.
Shared Gamma quotients are cancelled by exact finite recurrences before Euler conversion. Numerical source
samples are reused only within the current call; their cache contains no analytic answers.
For four and five remaining contour variables, two maps derived from the source Gamma curvature
and independent scrambled Sobol samples check the candidate. Identical completed checks are reused;
changing the source, contour or candidate cannot reuse an earlier acceptance.
Successful numerical checks are finite diagnostics, not rigorous error bounds. See `RUNTIME_RECORD.txt` for
release validation and its comparison qualifications.

## Cluster script (no front end)

```bash
math -script /path/to/MB_standard/run_standard.m                      # every target at its verified range; workers = the resource policy
TARGETS=MB3,MB6 WORKERS=15 math -script /path/to/MB_standard/run_standard.m
INTEGRAND_FILE=my_integrand.m ORDERS=-3,0 math -script /path/to/MB_standard/run_standard.m
```

`run_standard.m` is the same Standard route driven from the command line for a cluster node.  Everything is set by
environment variables, all optional: `TARGETS` (comma-separated benchmark targets or `all`), `ORDERS=min,max`,
`WORKERS` (maximum piece workers, default `Automatic` = the resource policy; the launcher prints the number it
started), `WORKER_MODE`
(`Subkernels`, the default, or `Processes`), `CACHE` and `RESUME` (default 1: reuse the exact disk cache and the
verified checkpoints; 0 recomputes), `INTEGRAND_FILE` (a `.m` file assigning `integrand`, evaluated with `ORDERS`
through `MBStandardEvaluate`) and `REPORT` (default `run_standard_report.txt` in this directory).  It prints the
per-order exact verdicts and ends with `RUN_STANDARD_RESULT=ALL_GREEN` or `NOT_GREEN`.  With `wolframscript` use
`wolframscript -file run_standard.m`.

## Regression with timing

```bash
wolframscript -file run_regression.wls                      # Standard route; workers = the resource policy
ROUTE=Subtraction wolframscript -file run_regression.wls    # Subtraction route: every target, one at a time
ROUTE=Subtraction TARGETS=MB6u,MB11 wolframscript -file run_regression.wls   # a selection
PK=15 wolframscript -file run_regression.wls                # a worker maximum of your own
```

recomputes every piece of every target (disk cache off, no checkpoint reuse, the run-time stores under `.cache/` set
aside first; `FRESH=0` keeps them) and writes `regression_report.txt`
with the per-target wall time, pass, exact-match and failed-piece verdicts and the line `REGRESSION_RESULT=ALL_GREEN`.
On the Subtraction route every inclusive target (to its verified maximum) and every u-dependent family (on its
Subtraction range) runs in a fresh kernel through `run_target.wls`, one after another; one target alone:

```bash
KIND=u NAME=MB6u LO=-5 HI=1 WolframKernel -noinit -noprompt -script run_target.wls
KIND=inc NAME=MB11 LO=-7 HI=-1 WolframKernel -noinit -noprompt -script run_target.wls
```

An inclusive target is compared with its exact benchmark (`mb_targets_all.m`); a u-dependent family with the release's
Standard records (`mbu_results.m`) and with the Subtraction records of the families (`mbu_subtraction_records.m`) at
u = 1/5, 1/3, 3/7, 4/5 — every order of the range must be compared and agree; the numbers are evaluated on
`CMP_KERNELS` subkernels (default 16), and `RAW_FROM=<path of a saved NAME_LO_HI_raw.m>` compares a saved result again
without recomputing it.  `ROUTE=Subtraction R3=1` runs the regression of release R3 instead.
The measurements of the release — both routes from scratch, every one of the thirty targets exact (4–5 October 2026:
the Subtraction route, every inclusive target to its verified maximum and every u-dependent family, one at a time,
19 h 32 min; 5 October 2026: the Standard route, the fourteen families in 52 min and the sixteen inclusive targets in
5 h 52 min), the kernels each target launched, the notebook checks, the verified maxima and the seal history — are in
`RUNTIME_RECORD.txt`; `regression_test.pdf` and `benchmark_status.pdf` are generated from the same run records.  In the notebook (disk cache and
checkpoints on) a target that has already been evaluated returns from its checkpoint.

## The Subtraction route (one-fold tower-closure rung, 2026-09-08)

`MBresolveToMPL[..., "Route" -> "Subtraction"]` is the subtraction scheme of MBSymbolicInt: after MBresolve, every 0-fold
residue is expanded, every 1-fold residue is closed by summing the residues of the poles on one side of its contour
(Gamma-front towers, i.e. prefactor × pFq(±1), plus the finitely many crossed poles), and the hypergeometric blocks are
expanded with HypExp; a residue with two contours is reduced by its own Barnes reduction and closed by the same piece
workers as the Standard route.  The rung `mbeOneFoldTowerRung.m` makes this route reach the full benchmark range of
the one-fold targets and of MB4 automatically: both closure directions are tried, the blocks are brought to a normal
form (parameter cancellation, Gauss's theorem, the contiguous rewriting Mathematica applies), each block is expanded
to the minimal depth its full prefactor requires, distinct blocks are expanded concurrently on subkernels, and the
route fails closed on anything it cannot expand exactly.  A residue with two or more contours goes through the
**faithful-cube rung** (`mbeFaithfulCubeRung.m`): the Barnes-kernel inversion of the residue into one Euler cube
(the `"v2"` rules: integer-distance Γ cancellation, Beta partners whose ratio is free of the other variables,
rationals of one gradient merged into one Euler variable, faces by the master subtraction equation; the earlier
rules remain as the fallback), whose ε-coefficients split into log-monomial pieces integrated exactly on subkernels
and banked per order and per piece under `.cache/fcu/`, so a second run of the same integral in the same folder skips
the cube.  Verified to the full benchmark range of MB1 (ε⁻³ … ε⁵), MB2 (ε⁻² … ε⁴), MB7 (ε⁻⁵ … ε³) and MB4
(ε⁻⁷ … ε¹), every coefficient exact and canonically equal to the benchmark; seconds, kernels and the per-residue
detail of MB4 are in `RUNTIME_RECORD.txt`, section 2.  Where a benchmark row carries `Zeta[5,3]` (MB1 ε⁵, MB2 ε⁴,
MB7 ε³) the ledger identifies the route's harmonic-sum constant `HPL`HPLs8a` = S(5,3;∞) = ζ(8) + ζ(5,3) with
`Zeta[8] + Zeta[5,3]` for the exact comparison and substitutes the multiple zeta value ζ(5,3) = 0.0377076729848475…
for the numeric one; Mathematica's Hurwitz `Zeta[5,3]` is never evaluated.

From the command line: `TARGETS=MB1,MB2,MB7 ORDERS=-3,5 ROUTE=Subtraction WORKERS=64 wolframscript -file run_standard.m`
(`ROUTE` is also read by `run_regression.wls`); in a session, set `$MBSerialRoute = "Subtraction"` before loading
`MBSymbolicInt_StandardRoute.wl`, or call `MBresolveToMPL` with `"Route" -> "Subtraction"` after `load_standard.m`.

## The general multifold handler of the Subtraction route (2026-09-29)

`mbeMultifoldHandler.m` closes the multi-fold residues of the Subtraction route in the differential-family form of
an inclusive target — the integrand carries an external parameter u with the endpoint factors u^a (1−u)^b, the
inclusive value is the exact u-integral — and sums the families to the inclusive Laurent expansion.  The chain, in
order: the u-integration at the MB level (exact Beta factors, unregulated endpoint terms kept for the eta step);
stabilized finite-ε Barnes reductions of the residue terms (first and second lemma, Gauss, unimodular pivots, the
crossed poles of every contour move taken exactly; a stabilization that leaves a pole on a contour line at the
decision point is retried at a nearby decision point); a census of the residue terms that pairs equal integrands on
different contours across residues, each pair admitted only after a pointwise identity gate; the closing chain of
`multifold_close/` (exact Series for zero-folds, the Barnes 2+2 closed forms, the one-fold tower ladder, the
Mellin–Parseval decoupling of coupled two-folds, the fixed-contour Taylor closer, the sealed-lane piece workers of the
Standard route, the slope-two closer with the package's exact last fold, the general two-fold closer — polygamma
split, Gamma copies by a finite-regulator Barnes lemma, generalized Barnes to an Euler kernel, Mellin tower at the
scale, folded exact last fold — and the jet rung, which takes every polygamma dressing of a unit-slope one-fold as
regulator jets of copied legs: the polygammas of a slope-two argument (also a square, a product or a derivative, up to
weight three) by integral representations with one exact outer fold each, the others by the one-fold ladder or the
Mellin tower at a scale, with the ε⁰ agreement of all samples and the contour quadrature as gates (a one-fold piece
with such a slope-two polygamma is taken in two passes: the fast closers, the tower ladder, the exact rewrite by the
multiplication theorem, then the slow engines) — and the
generalized-lemma rewrite, which takes a multi-fold piece that no Barnes lemma reduces
because legs of one variable are pinched: one fold by the regulated generalized Barnes lemma (a finite sum when the
defect of the kernel is a non-positive integer, a finite sum plus one tail otherwise; Barnes' first lemma for a 2+2
kernel), polygamma factors of the other variables carried as weights, the regulator-free part returned to the chain
as pieces with one fold fewer, the tail closed as a small dressed Euler cube by the package integrator or, when its
terms are rational in the summation index, summed to polygammas; the rewrite is applied level by level until one-fold
pieces remain, the fold identity and every part gated numerically); the eta step for the unregulated endpoint terms;
the family sum.  Every value is exact; a term the chain cannot close is left open and the run is reported
open, never completed with a number.  The handler is installed by `load_standard.m` in the multi-fold slot of the
route's family driver (the previous chain remains the fallback; `Global`$mfhAutoInstall = False` before loading keeps
the R2 behaviour).

The differential families are in `mb_u_targets.m` (MB8au, MB8bu, MB13u, MB14au, MB14bu and the others); the driver
resolves a family, runs the handler and compares the family sum with the inclusive benchmark of `mb_targets_all.m`
order by order (the benchmark enters only the comparison):

```bash
wolframscript -file run_multifold_family.wls MB13u                   # MB13 = the u-integral of MB13u, ε⁻⁷ … ε⁻³
wolframscript -file run_multifold_family.wls MB8u                    # MB8 = MB8au + MB8bu (a group name expands)
wolframscript -file run_multifold_family.wls MB14au MB14bu target=-3 low=-7 tag=r3   # workers from the policy
```

Options: `target` (highest order, default −3), `low` (lowest compared order, default −7), `e0` (decision point,
default −1/40), `seconds` (closing budget per term), `workers` (subkernels of the piece closers; default Automatic = the resource
policy's dynamic subkernel budget less a margin), `residues=1,2`
(a selection), `xpair=0` (no pairing across residues), `bench` (the benchmark symbol; default from the family name),
`order=asc|desc|mid|rot:k` (the order in which the residues are closed; the full list is kept, so the pairing and the
eta step see the same family), `items=asc|desc|mid|rot:k` (the order in which the items of a residue are closed),
`compare=0` (no benchmark comparison; exit code 0 when every residue closed), `claims=0` (no work sharing, see below),
`wait=1` and `state=dir` (another directory for the run-time caches).
The driver closes the residues, and the items of a residue, one after another and uses its workers inside an item.
Several processes of the same driver on the same family share the work: the closed items and pieces are stored under a
hash of their integrand and contour, a process claims an item before it closes it, and an item claimed by another
running process is not started a second time — the run that compares waits for it, a run with `compare=0` takes the
next item — so the processes move over the residues, and over the items of a residue with several heavy items, without
repeating each other.  `run_regression.wls` does this by itself on the Subtraction route: it starts the main run of
each family group and helper processes (`MULTIFOLD_HELPERS`, default 6; 0 = none; a helper takes both member families
of its group in its own residue and item order) first.  While they run, its own kernel closes the light targets of the
public route (MB1, MB2); the targets named in `PUBLIC_AFTER` (default MB4 and MB7, whose pieces need many subkernels
and integrator processes) run after the families, so that the node is not overloaded.  `MULTIFOLD_FAMILIES=MB13,MB8,MB14` selects
the groups and `MULTIFOLD_WORKERS` sets the piece workers per process (default: the resource policy's subkernel
budget split evenly over the processes).  The regression record is the main run's.
Records go to `.cache/multifold_family/` (per family, the sum, a text report); the closer's piece and term caches
and the census of open pieces live under `.cache/multifold_close/`; run-time state never enters the seal.  Exit code
0 means every residue closed and every compared order an exact match.  Verified from this folder: MB13, MB8 and
MB14 to ε⁻³ from empty caches (`RUNTIME_RECORD.txt`, section 10).  MB14au and MB14bu are resolvable families for this driver and are
not served by the differential route (`MBStandardRunU`).

## Release R3.1: every benchmark integral on the Subtraction route

With `$MBSerialRoute = "Subtraction"` every target of the ledger runs on the Subtraction route to the order it had been
computed to before (`MBSerialLedger[]`, column `SealedSubtractionMax`), and the u-dependent families run on it with
`MBSubtractionRunU` (above).  What makes the whole set automatic:

- **No silent hand-over to the Standard route.**  The family route takes residues of any fold count
  (`$oftMaxFold = Infinity`); a Subtraction request that would end on the Standard route says so
  (`MBresolveToMPL::substd`).
- **The inclusive target as the exact u-integral of its differential kernel.**  A ledger row with `SubtractionKernels`
  (MB5, MB6, MB9, MB10, MB11) is evaluated as the u-integral of its kernel in `mb_u_targets.m` at the MB level,
  G Γ(1+a)Γ(1+b)/Γ(2+a+b) for a kernel u^a (1−u)^b G — exact and unexpanded, the contours found afresh; the kernels have
  one fold fewer than the inclusive representations.  A row with `SubtractionFamilies` (MB8, MB14) is evaluated
  by the family driver `run_multifold_family.wls` (a main run and helper processes sharing the closer caches).
- **The decision point of the multi-fold handler** lies inside the interval in which the residue's own contours are
  pole-free, and **two legs on one pole lattice** are never summed as two simple towers.
- **Parallel residues.**  A closed multi-fold residue or term is stored under `.cache/oft_residues` (key: the code state,
  the residue, the regulator, the orders); for an integral with several such residues, helper processes
  (`oft_residue_helper.wls`, within the main-kernel budget of the resource policy) close them in other orders.
  `$oftResidueStore = False` before loading switches this off.
- **The u-dependent Subtraction route** (`mbeParameterSubtraction*.m`): exact scaled Barnes closure, the parameter factor
  times unscaled towers, faithful Euler cubes whose parameter signs are certified on 0 < u < 1, native periods on the
  guarded integrator (`vendor/IntVolFLINT/bin/hyperflint_guarded`: a letter factor not linear in the integration
  variable refuses the word instead of being dropped), an algebraic-root audit of every native record, the exact last
  fold for every record the audit does not certify (closed in parallel on subkernels), and — for a residue no Subtraction
  closer takes — the per-residue Standard closer as the last closer of that residue (never of the whole integral).
- **New exact moves of the multifold handler**: a polygamma of the fold variable on a first-lemma kernel
  (`multifold_close/uint_gle.m`), and a second full-depth attempt for a residue the previous chain refused.

## Release R3.2 (6 October 2026)

- The row of the eighth benchmark integral is **MB8**, the sum of the two phase-free five-folds MB8a + MB8b of
  `mb_targets_all.m` (`MBSerialRunSection["MB8", min, max]`; the row was called `MBpilot8` before this release).  The
  symbol `MB8` of `mb_targets_all.m` is the original five-fold with the phase E^(2 I π z6); the benchmark row evaluates
  its two phase-free components.
- The ledger and both notebooks list MB1–MB14, then the pilot integrals MBpilot12 and MBpilot13.
- `benchmark_status.pdf`: the coloured status chart of both routes.
- No file that computes a value changed (`RUNTIME_RECORD.txt`, section 17), so the regressions of R3.1 are the
  regressions of this release.

## What is in the folder

- `MBSymbolicInt.wl` — the sealed Standard-route core (a comment-sanitized copy of the sealed source with portable path
  defaults; no algorithmic change);
  `MB.m`, `MBresolve.m`, `barnesroutines.m` — the MB resolution and Barnes machinery; `IntVol_stable.m`,
  `IntVol_BigExpr_Helpers.m`, `intvol_*_prototype.m` — the Euler-integral backend and its exact-endpoint modules;
  `mbeSeqIntegrate.m`, `mbePinchClose.m` — the sequential and pinch closers.
- Strategy engines: `load_mbe_engines.m`, `hf_machinery.m`, `engineN_lib.m`, `engineN_grouped_lib.m`,
  `mbe_strategy_dispatch_v2.m`; the IntVolFLINT strategy hook `intvolflint/`.
- Class-handler rungs (sidecars wrapping saved definitions; the sealed core is never edited): `mbeReflZero.m`
  (reflection-zero one-folds), `mbeAffineBellRung.m` + `mbe_affine_bell_lib.m` (affine-Bell producer for
  ψ-dressed balanced one-folds), `mbeTwoVarPsiRung.m` (the Barnes-with-scale recursion: multi-variable polygamma
  arguments, degenerate pairings, slope-two legs, pure-Γ multi-folds, the exact-first policy and the
  two-construction gate), `mbeLevel6Reduce.m` + `level6_tables/` (sixth-root-of-unity constants),
  `mbeBarnesPreReduce.m` (Barnes' first lemma with polynomial absorption and crossed-pole residues on ≥ 3-folds),
  `mbeResonantResolve.m` (resonant representations: when MBresolve finds no straight contour because a
  zero-sum cycle of Gamma arguments pinches every contour, regulators are inserted on the smallest feasible hitting
  set of the epsilon-free Farkas certificates, tied along a generic ray, and the analytic continuation
  epsilon -> 0 then regulator -> 0 is carried out with MBcontinue; the result is memoised).  To measure the
  regulator independence of a new resonant integral, run it twice with `$mbrHittingSetChoice` / `$mbrRayChoice`
  set to different candidates (the log lists them) and compare the exact coefficients), `mbeOneFoldTowerRung.m`
  (the Subtraction route's tower-closure family: both closure directions, block normal form, minimal HypExp depth,
  parallel block expansion) and `mbeFaithfulCubeRung.m` (its multi-fold residues: Barnes-kernel inversion into one
  Euler cube, per-order pieces on subkernels, banked under `.cache/fcu/`).
- The general multifold handler (above): `mbeMultifoldHandler.m`; its closing chain `multifold_close/`
  (`uint_close_lib.m`, `uint_piece_chain.m`, `uint_b22_lib.m`, `uint_bn_lib.m`, `uint_bg_lib.m`, `uint_fcu_s2.m`,
  `uint_gb_euler.m` (the general two-fold closer), `uint_jet_rung.m` (the jet rung), `uint_gle.m` (the generalized-lemma
  rewrite), `uint_altint.m`, the subkernel
  workers `uint_ladder_worker.m`, `uint_piece_worker_bn.m`, and `mbeDiogenesFallback.m`, an optional hook that
  installs only when a DIOGENES package directory is present, see `THIRD_PARTY_NOTICES.md`; its companion
  `diog_service.wls` runs that expander in a separate main kernel on a spool directory when the subkernel pool is
  taken — also optional, used by no shipped value); the rungs it
  and the Subtraction route's family driver use: `mbe_barnes_lib.m`, `mbeMellinTowerRung.m`, `mbeRegulatedTowerRung.m`,
  `mbeSubtractionBarnesRung.m`, `mbeHypExpBlockBank.m`, `mbeAbelTowerRung.m`, `mbeSubtractionGaussBarnesRung.m`,
  `mbeGaussBarnesContinuationRung.m`, `mbeRegularHPLBoundaryRung.m`, `mbeFixedLetterGPLRung.m`,
  `mbeSharedAffineGaussRung.m`, `mbeSharedAffineStarRung.m`, `mbeSharedAffinePairRung.m`, `mbeGaussBranchJobs.m`,
  `mbeAffineEulerLeafRung.m`, `mbeAffineLogMomentRung.m`, `mbeWeightedAffineLogMomentRung.m`,
  `mbeSeparableEulerRung.m`, `mbeBilinearBetaRung.m`, `mbeAffineBlendRung.m`, `mbeFiniteEulerSumRung.m`,
  `mbeEulerCompositionRung.m`, `mbeTrigKernelRung.m`, `mbePositiveCubePowerCount.m`, `mbeJobConvergenceRung.m`,
  `mbeParameterSubtractionRoots.m`, `mbeExactLastFoldRung.m`, `mbeMultifoldFamilyRung.m`; the driver
  `run_multifold_family.wls`.
- `mbeFlagGuard.m`, loaded last by the loader: HPL and HypExp change their automatic-conversion switches globally
  during a call and restore them at its end, so a call stopped by a time limit used to leave them changed for the rest
  of the kernel's life (a term that closes in seconds in a fresh kernel was then refused in a long-running one; no
  value was affected).  The guard wraps the HypExp routines so that every exit leaves the switches as found, and the
  handler, the closer and the workers reset them at the start of each unit of work; a line `[flag-guard] ... restored`
  in a log marks a call that was interrupted.
- Parameter rungs: `mbeExternalParameterRung.m`, `mbeParameterResidueRung.m`, `mbeParameterEulerRung.m`,
  `mbeParameterTransverseRung.m`, `mbeParameterSixGammaRung.m`, `mbeParameterBarnesSecondRung.m`.
  `mbeResolveLP.m` is scoped to parameter resolution; the existing inclusive resolver is restored after each call.
  `parameter_support/contour_check.py` independently checks exact candidates on their source contours.
- The u-dependent Subtraction route (release R3.1): `mbeParameterSubtractionRung.m`, `mbeParameterSubtractionSeries.m`,
  `mbeParameterSubtractionCube.m`, `mbeParameterSubtractionDispatch.m`, `mbeParameterSubtractionHighFold.m`, the native
  drivers `mbe_parameter_subtraction_native.py` and `mbe_parameter_subtraction_native_par.py`; the residue store
  `mbeResidueStore.m` and its helper `oft_residue_helper.wls`.
- `mbt_piece_worker.m` — the process-parallel piece worker; `mb_targets_all.m` — the benchmark integrals and their
  exact benchmark expansions (comparison data only, never used by any producer); `mb_u_targets.m` — the u-dependent
  integrands and their ranges; `mbu_results.m`, `mbu_subtraction_records.m` — the Standard records and the Subtraction
  records of the u-dependent families (comparison data only); `MBSymbolicInt_StandardRoute.wl` — the
  executable source of both notebooks, `MBSymbolicInt_StandardRoute.nb` and `MBSymbolicInt_SubtractionRoute.nb` (each loads the
  source relative to `NotebookDirectory[]`); `run_regression.wls`, `run_target.wls`, `run_standard.m`;
  `configure_runtime.m`, `load_standard.m`; `run_multifold_family.wls`; `intvolflint/`, `level6_tables/`, `vendor/`.
- `RUNTIME_RECORD.txt` — the record of runtime: both regressions with per-target seconds and kernels, the notebook
  checks, the verified maxima, the seal history; `regression_test.pdf` (and its source `regression_test.tex`) — the
  regression record of the release; `benchmark_status.pdf` (source `benchmark_status.tex`) — the status chart of both
  routes.  `THIRD_PARTY_NOTICES.md` — licences.  `MANIFEST.sha256`, `SEAL_R32.sha256` — the seal (below).  The run-time state directories `.cache/`, `standard_serial_results/` and
  `worker_logs/` start empty.  The theory documents of the routes are not part of the release.

## The seal

`MANIFEST.sha256` lists the SHA-256 of every file (the run-time state directories excluded); `SEAL_R32.sha256` holds
the SHA-256 of the manifest.  From this directory:

```bash
sha256sum -c SEAL_R32.sha256 && sha256sum -c MANIFEST.sha256 --quiet && echo SEALED-R32-VERIFIES
```

A changed, added or removed file breaks the seal; superseded seal values are listed in `RUNTIME_RECORD.txt`.

## Conventions and gates (short)

Every served value passes an exactness predicate (no finite-precision atom, no residual variable or integrator
head).  A multi-fold piece of the rungs' exact-first classes is served only when two structurally different exact
constructions agree symbolically, or, when only one exists, when a cheap contour quadrature agrees; quadratures are
gates between exact candidates, never producers.  The per-order comparison with an exact benchmark is the arbiter
of a benchmark run.  The route is fail-closed: a timeout, a malformed certificate, an inexact atom or an unsupported
structure is recorded in the failed-piece ledger and the run is reported incomplete.
