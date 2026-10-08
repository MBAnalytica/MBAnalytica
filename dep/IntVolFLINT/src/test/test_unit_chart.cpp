// IVF: unit test for the native [0,1] chart word map (unit_chart.hpp).
#include "hyperflint/integrator/unit_chart.hpp"
#include "hyperflint/core/poly.hpp"
#include "hyperflint/core/rat.hpp"
#include <iostream>
#include <string>
#include <vector>

using namespace hyperflint;

namespace {
int g_failures = 0;
void check(bool cond, const std::string& msg) {
    if (!cond) {
        std::cerr << "FAIL: " << msg << "\n";
        ++g_failures;
    }
}
// Find the coefficient of a given word (by content) in a Wordlist; zero if absent.
Rat coef_of(const PolyCtx& ctx, const Wordlist& wl, const std::vector<std::string>& letters) {
    Word target;
    for (const auto& s : letters) target.letters.push_back(Rat::parse(ctx, s));
    for (const auto& t : wl.terms) {
        if (t.word.equal(target)) return t.coef;
    }
    return Rat::zero_of(ctx);
}
bool is_int(const PolyCtx& ctx, const Rat& r, long v) {
    return r.equal(Rat::from_int(ctx, v));
}
}  // namespace

int main() {
    PolyCtx ctx({"x", "y"});

    // [0]  ->  +[0]  -[-1]
    {
        Word w; w.letters.push_back(Rat::parse(ctx, "0"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 2, "[0]: two terms, got " + std::to_string(m.terms.size()));
        check(is_int(ctx, coef_of(ctx, m, {"0"}), 1),  "[0]: coef of [0] is +1");
        check(is_int(ctx, coef_of(ctx, m, {"-1"}), -1), "[0]: coef of [-1] is -1");
    }
    // [1]  ->  -[-1]
    {
        Word w; w.letters.push_back(Rat::parse(ctx, "1"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 1, "[1]: one term, got " + std::to_string(m.terms.size()));
        check(is_int(ctx, coef_of(ctx, m, {"-1"}), -1), "[1]: coef of [-1] is -1");
    }
    // [2]  ->  +[-2]  -[-1]     (2/(1-2) = -2)
    {
        Word w; w.letters.push_back(Rat::parse(ctx, "2"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 2, "[2]: two terms");
        check(is_int(ctx, coef_of(ctx, m, {"-2"}), 1),  "[2]: coef of [-2] is +1");
        check(is_int(ctx, coef_of(ctx, m, {"-1"}), -1), "[2]: coef of [-1] is -1");
    }
    // [y]  ->  +[y/(1-y)]  -[-1]
    {
        Word w; w.letters.push_back(Rat::parse(ctx, "y"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 2, "[y]: two terms");
        check(is_int(ctx, coef_of(ctx, m, {"y/(1-y)"}), 1), "[y]: coef of [y/(1-y)] is +1");
        check(is_int(ctx, coef_of(ctx, m, {"-1"}), -1),      "[y]: coef of [-1] is -1");
    }
    // [0,1]  ->  ([0] - [-1]) ⊗ (-[-1])  =  -[0,-1]  +[-1,-1]
    {
        Word w;
        w.letters.push_back(Rat::parse(ctx, "0"));
        w.letters.push_back(Rat::parse(ctx, "1"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 2, "[0,1]: two terms, got " + std::to_string(m.terms.size()));
        check(is_int(ctx, coef_of(ctx, m, {"0", "-1"}), -1), "[0,1]: coef of [0,-1] is -1");
        check(is_int(ctx, coef_of(ctx, m, {"-1", "-1"}), 1), "[0,1]: coef of [-1,-1] is +1");
    }
    // [0,0]  ->  [0,0] - [0,-1] - [-1,0] + [-1,-1]
    {
        Word w;
        w.letters.push_back(Rat::parse(ctx, "0"));
        w.letters.push_back(Rat::parse(ctx, "0"));
        Wordlist m = unit_chart_mobius_words(ctx, w);
        check(m.terms.size() == 4, "[0,0]: four terms");
        check(is_int(ctx, coef_of(ctx, m, {"0", "0"}), 1),    "[0,0]: [0,0] +1");
        check(is_int(ctx, coef_of(ctx, m, {"0", "-1"}), -1),  "[0,0]: [0,-1] -1");
        check(is_int(ctx, coef_of(ctx, m, {"-1", "0"}), -1),  "[0,0]: [-1,0] -1");
        check(is_int(ctx, coef_of(ctx, m, {"-1", "-1"}), 1),  "[0,0]: [-1,-1] +1");
    }
    // Coefficient map: 1/(1-x) -> 1+x ;  x -> x/(1+x) ;  1/x -> (1+x)/x
    {
        Rat c = unit_chart_map_coef(ctx, Rat::parse(ctx, "1/(1-x)"), 0);
        check(c.equal(Rat::parse(ctx, "1+x")), "coef 1/(1-x) -> 1+x, got " + c.to_string());
        Rat d = unit_chart_map_coef(ctx, Rat::parse(ctx, "x"), 0);
        check(d.equal(Rat::parse(ctx, "x/(1+x)")), "coef x -> x/(1+x), got " + d.to_string());
        Rat e = unit_chart_map_coef(ctx, Rat::parse(ctx, "1/x"), 0);
        check(e.equal(Rat::parse(ctx, "(1+x)/x")), "coef 1/x -> (1+x)/x, got " + e.to_string());
        // y-dependence untouched
        Rat f = unit_chart_map_coef(ctx, Rat::parse(ctx, "y/(x+y)"), 0);
        check(f.equal(Rat::parse(ctx, "y*(1+x)/(x+y+x*y)")),
              "coef y/(x+y) -> y(1+x)/(x+y+xy), got " + f.to_string());
    }
    // Term map: (1/(1-x)) * [1]  ->  -(1+x) [-1]
    {
        Word w; w.letters.push_back(Rat::parse(ctx, "1"));
        auto terms = unit_chart_map_term(ctx, Rat::parse(ctx, "1/(1-x)"), w, 0);
        check(terms.size() == 1, "term map: one term");
        if (!terms.empty()) {
            check(terms[0].first.equal(Rat::parse(ctx, "-(1+x)")), "term map: coef -(1+x), got " + terms[0].first.to_string());
            check(terms[0].second.size() == 1 && terms[0].second[0].equal(Rat::from_int(ctx, -1)),
                  "term map: word [-1]");
        }
    }

    if (g_failures == 0) {
        std::cout << "test_unit_chart: all checks passed\n";
        return 0;
    }
    std::cerr << "test_unit_chart: " << g_failures << " failure(s)\n";
    return 1;
}
