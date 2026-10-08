// IVF: native [0,1] chart for one integration variable (IntVolFLINT v1, 2026-08-29).
//
// HyperFLINT integrates every variable over [0, ∞): a primitive term
// coef(x)·Hlog_w(x) contributes  Reg_{x→∞} − Reg_{x→0}  through the
// "infinity expansion" and the "zero expansion" of integration_step.
// A finite interval is normally handled by rescale_interval, which maps
// the WHOLE integrand (all variables at once) projectively — the source
// of the degree doubling and LR-scan artifacts measured on the MB cubes.
//
// The unit chart keeps the integrand, the partial fractions, the
// primitive and the zero expansion in the natural x-chart of the
// current variable and maps ONLY the upper boundary, at the word level:
//
//   x = s/(1+s)   (x = 0 ↔ s = 0,  x = 1 ↔ s = ∞)
//   dlog(x − σ) = dlog(s − σ') − dlog(s + 1),   σ' = σ/(1 − σ)     (σ ≠ 1)
//   dlog(x − 1) = −dlog(s + 1)
//
// so that  Hlog_w(x(s)) = Σ ± Hlog_{w'}(s)  exactly (base point 0 on both
// sides; at most 2^|w| words over the letters {σ'_i, −1}), and
//
//   Reg_{x→1} P(x) = Reg_{s→∞} P(x(s)),   Reg_{x→0} P(x) = Reg_{s→0} P(x(s)).
//
// Hence  ∫_0^1 f dx  = [existing infinity expansion applied to the mapped
// terms]  −  [existing zero expansion applied to the original terms].
// No new period type is introduced: the keys leaving the step are the
// ordinary Reg_∞Reg_0 keys whose letters σ'(y) are rational in the
// remaining variables, which stay in their own natural chart.
#pragma once
#include "hyperflint/core/poly.hpp"
#include "hyperflint/core/rat.hpp"
#include "hyperflint/symbols/word.hpp"
#include <utility>
#include <vector>

namespace hyperflint {

// Hlog_w(x(s)) with x = s/(1+s), as a signed sum of words in s.
// Coefficients are ±1 (as Rat); identical words are merged.
Wordlist unit_chart_mobius_words(const PolyCtx& ctx, const Word& w);

// coef(x) with x → var/(1+var), the variable index being reused for s.
Rat unit_chart_map_coef(const PolyCtx& ctx, const Rat& coef, size_t var_idx);

// The pairs (coef_s · sign, w') to feed to the infinity expansion in
// place of the single (coef, w). Zero-coefficient pairs are dropped.
std::vector<std::pair<Rat, Word>>
unit_chart_map_term(const PolyCtx& ctx, const Rat& coef, const Word& w,
                    size_t var_idx);

// IVF (2026-08-30, symbolic kinematics): spectator (coefficient) variables are never integrated, so a
// Wm/Wp pair whose discriminant depends ONLY on spectators is a legitimate algebraic letter (IntVol's
// lambda letters).  Legacy HF/HyperIntica forbid it (the forbidden set = remaining integration vars UNION
// spectators).  With the scope enabled, ivf_filter_forbidden() removes the spectators from the forbidden set
// handed to LFForbiddenVarsScope; the divergence zero test keeps the full remaining set.
class IvfSpectatorLettersScope {
public:
    IvfSpectatorLettersScope(const std::vector<size_t>* spectators, bool enable);
    ~IvfSpectatorLettersScope();
    IvfSpectatorLettersScope(const IvfSpectatorLettersScope&) = delete;
    IvfSpectatorLettersScope& operator=(const IvfSpectatorLettersScope&) = delete;
private:
    const std::vector<size_t>* prev_;
    bool prev_enable_;
};
std::vector<size_t> ivf_filter_forbidden(const std::vector<size_t>& remaining);
bool ivf_spectator_letters_enabled();

}  // namespace hyperflint
