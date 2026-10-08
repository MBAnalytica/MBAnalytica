// narrow_ctx_flag — implementation.  See header for design rationale.

#include "hyperflint/runtime/narrow_ctx_flag.hpp"
#include <string>
#include <mutex>

// iter-93 §T7 twenty-third chunk Track-bridge macro-layer relocation:
// the tolerant-parse env-var literal now lives in the Track-bridge
// section of runtime/env_flags.hpp as HF_FLAG_PARSE_TOLERANT
// (rule-1 effect-domain = runtime; cached once-init below is the
// canonical reader). VALUE-family macro consistent with the other
// 16 macros resident in runtime/env_flags.hpp.
#include "hyperflint/runtime/env_flags.hpp"

#include <cstdlib>

namespace hyperflint {

std::atomic<bool> g_narrow_ctx_too_narrow{false};

void reset_narrow_ctx_flag() {
    g_narrow_ctx_too_narrow.store(false, std::memory_order_relaxed);
}

bool narrow_ctx_was_too_narrow() {
    return g_narrow_ctx_too_narrow.load(std::memory_order_relaxed);
}

std::atomic<bool> g_nonlinear_den_unsupported{false};

namespace { std::mutex g_ivf_detail_mx; std::string g_ivf_nonlinear_detail; }   // IVF
void set_nonlinear_den_detail(const std::string& what) {
    std::lock_guard<std::mutex> lk(g_ivf_detail_mx);
    if (g_ivf_nonlinear_detail.empty()) g_ivf_nonlinear_detail = what;
}
std::string nonlinear_den_detail() {
    std::lock_guard<std::mutex> lk(g_ivf_detail_mx);
    return g_ivf_nonlinear_detail;
}
void reset_nonlinear_den_flag() {
    g_nonlinear_den_unsupported.store(false, std::memory_order_relaxed);
    std::lock_guard<std::mutex> lk(g_ivf_detail_mx);
    g_ivf_nonlinear_detail.clear();
}

void set_nonlinear_den_flag() {
    g_nonlinear_den_unsupported.store(true, std::memory_order_relaxed);
}

bool nonlinear_den_was_unsupported() {
    return g_nonlinear_den_unsupported.load(std::memory_order_relaxed);
}

bool tolerance_enabled() {
    // Static-local once-init: the lambda runs exactly once at first
    // call across all threads, and `cached` is treated as immutable
    // thereafter.  Standard C++11 magic-static guarantee.
    static const bool cached = []() {
        const char* v = HF_FLAG_PARSE_TOLERANT;
        return v && *v && v[0] != '0';
    }();
    return cached;
}

}  // namespace hyperflint
