# Third-party notices

This release vendors only the files in the runtime closure of the Standard route. The original notices and
license files retained in the bundle are authoritative.

- PolyLogTools 1.4: Claude Duhr and Falko Dulat. See `vendor/PolyLogTools/README.md` and the package banner.
  The bundled copy carries the weight-7/8 multiple-zeta-value tables (`core/MZVw78.m`) and the sixth-root-of-unity
  module; its weight 7--10 boundary-value branch `core/ReduceCG78.m` depended on DIOGENES tables that are not
  shipped, is reached by no route, and is a fail-closed identity.
- HPL 2.0 and HypExp 2.0: Daniel Maitre and Tobias Huber. See `vendor/HPL/HPL_README`, `vendor/HPL/HPLnolicense`
  and `vendor/HypExp/README`. The bundled copies carry the project's weight-9/10 minimal-set and MZV tables.
- HyperIntica (SubTropica): M. Giroux, S. Mizera and G. Salvatori, *SubTropica*, arXiv:2604.20954; a native
  Mathematica reimplementation of E. Panzer's HyperInt (arXiv:1403.3385).  See `vendor/HyperIntica/LICENSE`,
  `vendor/HyperIntica/LICENSE-DATA` and `vendor/HyperIntica/README.md`.  Used by MB2MPL's IntVolFLINT strategy as
  the exact evaluator of hyperlogarithm words.
- IntVolFLINT, a fork of HyperFLINT 1.2.13 (SubTropica; M. Giroux, S. Mizera, G. Salvatori; MIT license): the fork's
  additions (marked `// IVF:` in the source) are by Syed Mehedi Hasan; the upstream code and its licence are retained:
  `vendor/IntVolFLINT/LICENSE`, `vendor/IntVolFLINT/THIRD-PARTY-LICENSES`, `vendor/IntVolFLINT/FORK_PROVENANCE.md`;
  source in `vendor/IntVolFLINT/src`, build notes in `vendor/IntVolFLINT/BUILD.md`.
- Henn--Smirnov--Smirnov tables of multiple polylogarithm values at sixth roots of unity (arXiv:1512.08389),
  weights 1--4 only: `level6_tables/PROVENANCE.md`.
- MB.m (M. Czakon), MBresolve.m (A. V. Smirnov, V. A. Smirnov) and the Barnes routines retain their original source
  headers and startup attribution in the root-level `.m` files.
- DIOGENES (M. A. Bezuglov, A. I. Onishchenko, arXiv:2312.06242; GPL-3.0) is NOT shipped.  The multifold handler's
  `multifold_close/mbeDiogenesFallback.m` is an optional hook for its differential-equation expansion of a
  hypergeometric block; it installs only when a DIOGENES package directory (`DIOGENES.wl`) is present at
  `Global`$MBStandardDiogenesPath` or `vendor/DIOGENES/`, and no value of the record depends on it.

GiNaC/CLN (the `ginsh` shell used by PolyLogTools for numerics) and Mathematica are external prerequisites and are
not part of this bundle.
