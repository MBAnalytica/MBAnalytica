# MBAnalytica

**Analytic Evaluation of Mellin–Barnes Integrals**

`MBAnalytica` is a *Mathematica* package that evaluates multifold Mellin–Barnes (MB) integrals analytically, as a
Laurent series in the dimensional regulator, with every coefficient written in terms of multiple polylogarithms
(MPLs), zeta values, π and γ<sub>E</sub>.  A single command, `MBEvaluate`, takes the MB integrand as it comes from an
MB representation, resolves its ε-singularities and returns the expansion through a requested order with one of
three complementary methods:

| Method | Idea |
|---|---|
| `"Standard"` | expand the residues in ε first, convert every coefficient integral into an Euler integral on the unit cube, and integrate it by the method of hyperlogarithms |
| `"Subtraction"` | keep ε symbolic, subtract the boundary singularities of the Euler integral, then expand and integrate; usually reaches deeper orders |
| `"Resum"` | close the contours, build the hypergeometric series with `MBConicHulls.wl`, and resum them with `EvaluateMultiSums`, `Sigma` and `HarmonicSums` |

A coefficient is either closed exactly or returned as open (`MBFailed[...]`); it is never approximated.  The
methods succeed under different conditions (linear reducibility and summability), so wherever two of them close the
same order they check each other.

The package is described in

> T. Ahmed, S. Banik, S. M. Hasan, A. Rapakoulias, *MBAnalytica: Analytic Evaluation of Mellin–Barnes Integrals*
> (2026), submitted to Computer Physics Communications.

and the algorithms of the integration methods in the companion paper *The anatomy of singular Feynman integrals*.

---

## Requirements

* **Mathematica 14.0 or later.**  The package is validated with Mathematica 15.0 on Linux (Ubuntu and RHEL).  The
  `Makefile` also has a macOS branch (Homebrew); it has not been validated yet.
* **System packages** for the `Standard` and `Subtraction` methods: a C++ compiler, `cmake`, `pkg-config`, `patch`,
  `GMP`, `MPFR`, `FLINT` (version 3.4 or later; an older system FLINT is replaced by a private build), the GiNaC
  shell `ginsh`, and `Python 3` (with `numpy`, `scipy` and `sympy`, which `make` installs into a private `.venv`).
* **The RISC packages** for the `Resum` method: `HarmonicSums`, `Sigma` and `EvaluateMultiSums`, from
  [risc.jku.at/sw/harmonicsums](https://risc.jku.at/sw/harmonicsums/),
  [risc.jku.at/sw/sigma](https://risc.jku.at/sw/sigma/) and
  [risc.jku.at/sw/evaluatemultisums](https://risc.jku.at/sw/evaluatemultisums/).  Follow the download
  instructions on those pages and put the three packages into one folder.  They are distributed by RISC as encoded
  Mathematica packages; they are not bundled with `MBAnalytica`.
* **The weight-9 and weight-10 HPL tables** (`h9table.mat`, `h10table.mat`, `ms9_rules.mx`, `mspm9_rules.mx`,
  `ms10_rules_v2.mx`, `mspm10_rules.mx`; about 400 MB in total).  They are too large for git and are distributed
  separately <!-- AUTHORS: add the download link (e.g. a GitHub release asset or Zenodo) and set TABLES_URL in the Makefile -->;
  `make` verifies them against `dep/HPL_TABLES.sha256`.

A method whose dependencies are missing is switched off; the other methods remain usable.

## Installation

```bash
git clone https://github.com/MBAnalytica/MBAnalytica.git
cd MBAnalytica
```

**1. System packages.**  `make deps` prints the command that installs them on this machine (`apt` on Debian and
Ubuntu, `dnf` on Fedora and RHEL, `brew` on macOS); `make deps CONFIRM=yes` runs it.  For instance, on Ubuntu:

```bash
sudo apt install cmake g++ pkg-config patch libflint-dev libgmp-dev libmpfr-dev ginac-tools python3-venv
```

**2. Build.**  Give the folder of the RISC packages and the folder of the HPL tables:

```bash
make RISC=/path/to/RISC TABLES=/path/to/HPL-tables
```

This checks the tools, builds the hyperlogarithm integrator (the IntVolFLINT fork of HyperFLINT, in a plain and a
guarded variant), creates the Python environment, copies and verifies the HPL tables, and writes `config.m` with the
paths found on this machine.  `RISC` may be omitted when the RISC packages are already on Mathematica's `$Path`.
Further variables: `WOLFRAMSCRIPT=/path/to/wolframscript`, `GINSH=/path/to/ginsh`, `CMAKE=/path/to/cmake`,
`PYTHON=/path/to/python3` and `JOBS=8`.

**3. Test.**

```bash
make test
```

loads the package in a fresh kernel, reports every dependency, and evaluates one known integral with every method
available on the machine (a few minutes).

**4. Install.**

```bash
make install
```

adds the folder to Mathematica's `$Path` (one line in `$UserBaseDirectory/Kernel/init.m`); `make uninstall` removes
it, and `make clean` removes the build, the Python environment and the copied tables.

## Usage

```mathematica
<< MBAnalytica.wl
```

prints the version and the methods available on the machine.  `MBAnalyticaCheck[]` reports every dependency, how to
obtain a missing one and which methods it blocks.

The integrand is written with Gamma and polygamma functions of linear arguments, powers of the kinematic variables
and an optional prefactor; the contours are not given.  The integration variables are the symbols inside the Gamma
and polygamma functions, the kinematic variables are the remaining symbols, and they are taken in 0 < x < 1.  For the
one-fold integral of the installation test,

```mathematica
In[]:=  MB1 = E^(2 (EulerGamma + I Pi) \[Epsilon]) Gamma[\[Epsilon]] Gamma[1 - 2 \[Epsilon]]
          Gamma[2 - 4 \[Epsilon]] Gamma[4 - 4 \[Epsilon]]/(Gamma[2 - 2 \[Epsilon]] Gamma[4 - 8 \[Epsilon]])
          Gamma[-z] Gamma[1 - z - 3 \[Epsilon]] Gamma[1 + z - \[Epsilon]] Gamma[z + \[Epsilon]]^2/
          Gamma[2 + z - 3 \[Epsilon]];

In[]:=  MBEvaluate[MB1, {\[Epsilon], 0}]
Out[]=  13600/27 - (647 Pi^2)/18 + 1/\[Epsilon]^3 + 25/(3 \[Epsilon]^2)
        + (584/9 - (13 Pi^2)/3)/\[Epsilon] - (380 Zeta[3])/3
```

`MBEvaluate[MBInt, vars, {eps, ord}]` names the kinematic variables `vars` explicitly.

### Options of `MBEvaluate`

| Option | Default | Meaning |
|---|---|---|
| `Method` | `Automatic` | `"Resum"`, `"Standard"` or `"Subtraction"` uses that method alone; `Automatic` tries the available methods in this order, each one only on the orders the earlier ones left open |
| `Complex` | `False` | `False` returns the real part (checked numerically against the full value when some function is not real on 0 < x < 1); `True` returns the full complex value |
| `BarnesReduce` | `True` | apply the first and second Barnes lemmas before the `Resum` method solves the integral |
| `Verbose` | `False` | print one line per stage of the calculation |

### Output

Every coefficient is a combination of the MPLs `` PolyLogTools`G[a1, ..., an, x] ``, logarithms, zeta values, π and
γ<sub>E</sub>.  When the `Resum` method sums a series that converges only in part of the domain, the result is a
`ConditionalExpression` that states this region.  A coefficient that no method could close is returned as
`MBFailed[reasons]`, with a message naming the open orders; the other orders are unaffected.  MPLs can be evaluated
numerically with `GiNaC`, for instance with `` PolyLogTools`Ginsh[expr, {x -> value}] ``.

### Global settings

| Symbol | Meaning |
|---|---|
| `$KernelLaunch` | number of parallel subkernels (default at most 4, one per core and what the free memory holds); set it before the first evaluation |
| `$MBAnalyticaCacheDirectory` | folder of the caches and logs (default `$UserBaseDirectory/ApplicationData/MBAnalytica`); closed pieces are reused by later evaluations |
| `$MBAnalyticaRISCPath` | folder of `HarmonicSums`, `Sigma` and `EvaluateMultiSums` when they are not on `$Path` (`make RISC=...` records it) |
| `$MBAnalyticaMethods` | the methods that can run on this machine |
| `$MBAnalyticaVersion`, `$MBAnalyticaDirectory` | the version of the package and the folder it was loaded from |

Every public symbol has a usage message, e.g. `?MBEvaluate`.

## Benchmarks

`tests/benchmark` holds a suite of MB integrals with known Laurent expansions, inclusive and differential in a
kinematic variable, with one to eight folds.  `make benchmark` recomputes them and compares every coefficient with its
reference value (this takes hours).

## Repository layout

| Path | Content |
|---|---|
| `MBAnalytica.wl`, `PacletInfo.wl` | the package entry point and the public symbols |
| `src/Core` | `MBEvaluate`, the dependency check, the output basis and the portability layer |
| `src/Resum` | the `Resum` method |
| `src/MB2MPL` | the `Standard` and `Subtraction` methods (MB2MPL engine) |
| `dep` | bundled third-party packages (see below) and the build of the hyperlogarithm integrator |
| `tests` | the installation test and the benchmark suite |

## Bundled software

`MBAnalytica` bundles `MB.m` (M. Czakon), `MBresolve.m` (A. V. Smirnov, V. A. Smirnov) and the Barnes routines,
`MBConicHulls.wl` (arXiv:2012.15108, 2212.11839, 2309.00409, 2512.19803), `PolyLogTools` (C. Duhr, F. Dulat), `HPL`
(D. Maître), `HypExp` (T. Huber, D. Maître), `HyperIntica` and an extension of the hyperlogarithm integrator
`HyperFLINT` (M. Giroux, S. Mizera, G. Salvatori, *SubTropica*).  Their original notices and licence files are kept in
`dep/`; see [`dep/THIRD_PARTY_NOTICES.md`](dep/THIRD_PARTY_NOTICES.md).  Please cite these packages together with
`MBAnalytica` when you use the corresponding methods.

## Licence

`MBAnalytica` is distributed under the GNU General Public License v3; see [`LICENSE`](LICENSE).

## Authors

Taushif Ahmed (University of Regensburg), Sumit Banik (SLAC National Accelerator Laboratory, Stanford University),
Syed Mehedi Hasan (University of Regensburg), Andreas Rapakoulias (University of Regensburg).

Questions and bug reports: please open an issue on GitHub.
