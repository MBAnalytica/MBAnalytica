# Fork provenance (IntVolFLINT)

- Fork author: Syed Mehedi Hasan (the IntVolFLINT additions, marked `// IVF:` in the source).
- Upstream: HyperFLINT 1.2.13 by M. Giroux, S. Mizera and G. Salvatori (SubTropica, arXiv:2604.20954), MIT license, retained in full.

- Source: the developer's HyperFLINT working tree, git `adfd3af` (SubTropica v1.2.13,
  https://github.com/SubTropica/SubTropica.git), copied 2026-08-29.
- The working tree carried ONE uncommitted local change, kept in this fork: `bridge/cli/main.cpp`
  (`handle_integration_step`: clears `AlgebraicLetterTable` per request and emits the `algebraic_letters`
  table in the standalone `integration_step` response).  This is the code behind the production binary
  `build-mb8-exact/hyperflint` (`HF_BUILD_VARIANT=mb8-exact-commit-adfd3af`).
- Build directories are NOT copied (build outside Dropbox: `~/work/build/intvolflint-v1`).
- License: MIT (see LICENSE).  All IntVolFLINT changes are marked `// IVF:` in the source.


## 2026-08-30 — spectator algebraic letters (symbolic kinematics)
- `include/hyperflint/integrator/unit_chart.hpp`, `src/integrator/unit_chart.cpp`: `IvfSpectatorLettersScope`, `ivf_filter_forbidden`.
- `src/integrator/integration_step.cpp`: forbidden set for `LFForbiddenVarsScope` = `ivf_filter_forbidden(remaining)`; captures the
  worker's nonlinear-factor message (`set_nonlinear_den_detail`) and rethrows `NonlinearDenominatorUnsupported(detail)`.
- `include/hyperflint/integrator/integration_step.hpp`: detail constructor.  `include/.../runtime/narrow_ctx_flag.hpp`,
  `src/runtime/narrow_ctx_flag.cpp`: detail string (mutex), cleared with the flag.
- `src/algebra/partial_fractions.cpp`: refusal message names degree_in_var / multiplicity / polynomial of the first nonlinear factor.
- `include/.../integrator/hyper_int.hpp`, `src/integrator/hyper_int.cpp`: `hyperflint_sym(..., bool ivf_spectator_letters=false)`.
- `src/bridge/handlers.cpp`: JSON flag `"spectator_algebraic_letters"` (regex, like `native_unit_interval`), passed to both calls.
Default off ⇒ legacy behaviour bit-for-bit.
