# MBAnalytica

`MBAnalytica` is a Mathematica package for the analytic evaluation of Mellin–Barnes (MB) integrals, as Laurent expansions in the dimensional regulator ε whose coefficients are given in terms of multiple polylogarithms.

The package first resolves the ε-singularities of the input with [MB.m](https://gitlab.com/feynmanintegrals/MB) and MBresolve.m. The resulting integrals are then evaluated with three complementary methods. The methods `ExpandInt` and `Subtraction` convert them into Euler integrals over the unit cube and integrate these by the method of hyperlogarithms, either after the expansion in ε or after the boundary singularities have been subtracted with ε kept symbolic. The method `SymbolicSum` closes the integration contours and sums the resulting series symbolically. A coefficient that none of the methods can close is returned as open, and never as an approximation.

More details can be found in T. Ahmed, S. Banik, S. M. Hasan and A. Rapakoulias, *MBAnalytica: Analytic Evaluation of Mellin–Barnes Integrals* (2026).

## Dependencies

`MBAnalytica.wl` requires Mathematica 14 or later and the following external tools:

- [HarmonicSums](https://risc.jku.at/sw/harmonicsums/), [Sigma](https://risc.jku.at/sw/sigma/) and [EvaluateMultiSums](https://risc.jku.at/sw/evaluatemultisums/), used by the method `SymbolicSum`  
  J. Ablinger, [arXiv:1011.1176](https://arxiv.org/abs/1011.1176); C. Schneider, [arXiv:1310.0160](https://arxiv.org/abs/1310.0160)

- [GiNaC](https://www.ginac.de/) (the shell `ginsh`), [FLINT](https://flintlib.org/), GMP, MPFR, `cmake`, a C++ compiler and Python 3 with numpy, scipy and sympy, used by the methods `ExpandInt` and `Subtraction`  
  C. Bauer, A. Frink and R. Kreckel, [arXiv:cs/0004015](https://arxiv.org/abs/cs/0004015)

The following packages are downloaded by the installation from the pages of their authors, since they are not distributed with this repository:

- [MB.m, MBresolve.m and barnesroutines.m](https://gitlab.com/feynmanintegrals/MB)  
  M. Czakon, [arXiv:hep-ph/0511200](https://arxiv.org/abs/hep-ph/0511200); A. V. Smirnov and V. A. Smirnov, [arXiv:0901.0386](https://arxiv.org/abs/0901.0386); D. A. Kosower

- [MBConicHulls.wl](https://github.com/SumitBanikGit/MBConicHulls)  
  S. Banik and S. Friot, [arXiv:2212.11839](https://arxiv.org/abs/2212.11839)

- [PolyLogTools](https://gitlab.com/pltteam/plt)  
  C. Duhr and F. Dulat, [arXiv:1904.07279](https://arxiv.org/abs/1904.07279)

- [HPL](https://www.physik.uzh.ch/data/HPL/) and [HypExp](https://www.physik.uzh.ch/data/HypExp/)  
  D. Maître, [arXiv:hep-ph/0507152](https://arxiv.org/abs/hep-ph/0507152); T. Huber and D. Maître, [arXiv:hep-ph/0507094](https://arxiv.org/abs/hep-ph/0507094), [arXiv:0708.2443](https://arxiv.org/abs/0708.2443)

The repository includes `HyperIntica` and an extension of the integrator `HyperFLINT` of [SubTropica](https://github.com/SubTropica/SubTropica) (M. Giroux, S. Mizera and G. Salvatori, [arXiv:2604.20954](https://arxiv.org/abs/2604.20954)), in versions modified for `MBAnalytica`. The changes applied to the downloaded HPL and PolyLogTools are described in `dep/THIRD_PARTY_NOTICES.md`.

## Installation

1. Clone this repository:

```bash
git clone https://github.com/MBAnalytica/MBAnalytica.git
cd MBAnalytica
```

2. Install the system packages. The command for your system is printed by

```bash
make deps
```

   and `make deps CONFIRM=yes` runs it.

3. Build the package, giving the folder that contains `HarmonicSums`, `Sigma` and `EvaluateMultiSums`:

```bash
make RISC=/path/to/RISC
```

   This downloads the packages listed above and the tables of weight nine and ten (about 130 MB, from the release `hpl-tables-v1`), checks them against their checksums, builds `HyperFLINT` and writes `config.m`. On a machine without internet access, `make UPSTREAM=/path TABLES=/path` uses local copies instead.

4. Check the installation and add the folder to Mathematica's `$Path`:

```bash
make test
make install
```

5. Load the package in Mathematica and check the installation:

```mathematica
<< MBAnalytica.wl
MBAnalyticaCheck[]
```

   `MBAnalyticaCheck[]` lists every dependency that was found, says how to obtain a missing one, and reports which of the methods `SymbolicSum`, `ExpandInt` and `Subtraction` can run on the machine.

6. Evaluate an MB integral. For instance, `MBEvaluate[MB1, {ε, 0}]` returns the Laurent expansion of the MB integrand `MB1` through ε<sup>0</sup>. The notebook `Examples_MBAnalytica.nb` shows the examples of the paper.

## Files

| File | Description |
|------|-------------|
| `MBAnalytica.wl` | Main package file |
| `src/` | The three methods, the top-level command `MBEvaluate` and the command `CosmoTreeMB` |
| `dep/` | Bundled packages, and the folders into which the downloaded packages and tables are installed |
| `tests/` | Installation test and benchmark integrals |
| `examples/` | Closed forms of the expansions of the double-exchange bispectrum |
| `Examples_MBAnalytica.nb` | Example evaluations |
| `Makefile` | Installation |

## Authors

- Taushif Ahmed (University of Regensburg) — [taushif.ahmed@ur.de](mailto:taushif.ahmed@ur.de)
- Sumit Banik (SLAC National Accelerator Laboratory, Stanford University) — [banik@stanford.edu](mailto:banik@stanford.edu)
- Syed Mehedi Hasan (University of Regensburg) — [syed-mehedi.hasan@ur.de](mailto:syed-mehedi.hasan@ur.de)
- Andreas Rapakoulias (University of Regensburg) — [andreas.rapakoulias@ur.de](mailto:andreas.rapakoulias@ur.de)

`MBAnalytica` is distributed under the GNU General Public License v3.
