// IVF: native [0,1] chart — implementation (see unit_chart.hpp).
#include "hyperflint/integrator/unit_chart.hpp"
#include "hyperflint/reduce/mzv_reduce.hpp"   // substitute_var_rat
#include <string>
#include <vector>
#include <unordered_map>

namespace hyperflint {

// IVF spectator-letters scope (thread-local; see unit_chart.hpp)
namespace {
thread_local const std::vector<size_t>* g_ivf_spectators = nullptr;
thread_local bool g_ivf_spectator_letters = false;
}  // namespace
IvfSpectatorLettersScope::IvfSpectatorLettersScope(const std::vector<size_t>* spectators, bool enable)
    : prev_(g_ivf_spectators), prev_enable_(g_ivf_spectator_letters) {
    g_ivf_spectators = spectators;
    g_ivf_spectator_letters = enable;
}
IvfSpectatorLettersScope::~IvfSpectatorLettersScope() {
    g_ivf_spectators = prev_;
    g_ivf_spectator_letters = prev_enable_;
}
bool ivf_spectator_letters_enabled() { return g_ivf_spectator_letters; }
std::vector<size_t> ivf_filter_forbidden(const std::vector<size_t>& remaining) {
    if (!g_ivf_spectator_letters || g_ivf_spectators == nullptr || g_ivf_spectators->empty()) return remaining;
    std::vector<size_t> out;
    out.reserve(remaining.size());
    for (size_t v : remaining) {
        bool is_spec = false;
        for (size_t s : *g_ivf_spectators) { if (s == v) { is_spec = true; break; } }
        if (!is_spec) out.push_back(v);
    }
    return out;
}


namespace {

// One letter's image under x = s/(1+s):
//   σ ≠ 1 :  (+1, σ/(1−σ)),  (−1, −1)
//   σ = 1 :  (−1, −1)
std::vector<std::pair<int, Rat>>
letter_images(const PolyCtx& ctx, const Rat& sigma) {
    const Rat one       = Rat::one_of(ctx);
    const Rat minus_one = Rat::from_int(ctx, -1);
    std::vector<std::pair<int, Rat>> out;
    if (!sigma.equal(one)) {
        out.emplace_back(+1, sigma / (one - sigma));
    }
    out.emplace_back(-1, minus_one);
    return out;
}

}  // namespace

Wordlist unit_chart_mobius_words(const PolyCtx& ctx, const Word& w) {
    // Iteratively build the signed product over the letters (outermost
    // letter first, as stored in Word).
    std::vector<std::pair<int, Word>> partial;
    partial.emplace_back(+1, Word{});
    for (const auto& letter : w.letters) {
        const auto images = letter_images(ctx, letter);
        std::vector<std::pair<int, Word>> next;
        next.reserve(partial.size() * images.size());
        for (const auto& p : partial) {
            for (const auto& im : images) {
                Word nw = p.second;
                nw.letters.push_back(im.second);
                next.emplace_back(p.first * im.first, std::move(nw));
            }
        }
        partial.swap(next);
    }
    // Merge identical words (content key) so ±1 cancellations disappear.
    std::unordered_map<std::string, size_t> index;
    Wordlist out;
    for (auto& p : partial) {
        const std::string key = p.second.content_key();
        auto it = index.find(key);
        if (it == index.end()) {
            index.emplace(key, out.terms.size());
            out.terms.push_back(WordlistTerm{Rat::from_int(ctx, p.first),
                                             std::move(p.second), std::nullopt});
        } else {
            out.terms[it->second].coef =
                out.terms[it->second].coef + Rat::from_int(ctx, p.first);
        }
    }
    // Drop exact cancellations.
    Wordlist pruned;
    for (auto& t : out.terms) {
        if (!t.coef.is_zero()) pruned.terms.push_back(std::move(t));
    }
    return pruned;
}

Rat unit_chart_map_coef(const PolyCtx& ctx, const Rat& coef, size_t var_idx) {
    const Rat var(Poly::gen(ctx, var_idx));
    const Rat one = Rat::one_of(ctx);
    const Rat replacement = var / (one + var);
    return substitute_var_rat(ctx, coef, var_idx, replacement);
}

std::vector<std::pair<Rat, Word>>
unit_chart_map_term(const PolyCtx& ctx, const Rat& coef, const Word& w,
                    size_t var_idx) {
    std::vector<std::pair<Rat, Word>> out;
    const Rat coef_s = unit_chart_map_coef(ctx, coef, var_idx);
    if (coef_s.is_zero()) return out;
    Wordlist words = unit_chart_mobius_words(ctx, w);
    out.reserve(words.terms.size());
    for (auto& t : words.terms) {
        Rat c = coef_s * t.coef;
        if (c.is_zero()) continue;
        out.emplace_back(std::move(c), std::move(t.word));
    }
    return out;
}

}  // namespace hyperflint
