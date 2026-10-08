# Building the hyperlogarithm integrator (IntVolFLINT, a fork of HyperFLINT 1.2.13)

Fork author: Syed Mehedi Hasan (IntVolFLINT additions).  Upstream HyperFLINT: M. Giroux, S. Mizera, G. Salvatori (SubTropica), MIT license.

The release ships a Linux x86-64 binary at `bin/hyperflint` (dynamically linked against libgmp, libmpfr, libgomp,
libstdc++).  `configure_runtime.m` runs `hyperflint --version` at load time; if that fails on your machine, rebuild:

Prerequisites (beyond the C++17 compiler you already have): CMake >= 3.16, FLINT (>= 3.0), GMP, MPFR, an OpenMP runtime.
On Debian/Ubuntu: `apt install cmake libflint-dev libgmp-dev libmpfr-dev`.

```bash
cd vendor/IntVolFLINT/src
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
cp build/hyperflint ../bin/hyperflint
../bin/hyperflint --version     # must print HF_VERSION 1.2.13
```

The Mathematica side talks to the binary through JSON on stdin/stdout (`hyperflint eval-json`); no library linking with
Mathematica is involved.  `data/mzv_reductions.json` is the reduction table the binary reads (passed by absolute path).
The fork's changes to the original HyperFLINT are marked `// IVF:` in the source and listed in `FORK_PROVENANCE.md`;
with all fork options off the binary behaves as the original 1.2.13, which is why a single binary serves both bridges
(`hf_machinery.m` and `intvolflint/`).  License: MIT (see `LICENSE`, `THIRD-PARTY-LICENSES`).
