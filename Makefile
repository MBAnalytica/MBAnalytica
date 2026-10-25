# MBAnalytica: build and check everything inside this folder.
#
#   make            check the tools, download MB.m, MBresolve.m, the Barnes routines, HPL and HypExp from their
#                   authors' pages, build HyperFLINT, create the Python environment, fetch the large HPL tables,
#                   write config.m
#   make test       run the installation test (a few minutes)
#   make deps       show the commands that install the missing system packages; CONFIRM=yes runs them
#   make install    put this folder on Mathematica's $Path (one line in init.m); make uninstall removes it
#   make benchmark  the MB1-MB14 benchmarks of the paper (hours)
#   make clean      remove the build, the Python environment, the downloaded packages and the downloaded tables
#
# Variables:  RISC=/folder/with/HarmonicSums-Sigma-EvaluateMultiSums
#             TABLES=/folder/with/the/HPL/tables (optional: otherwise they are downloaded from TABLES_URL)
#             UPSTREAM=/folder with HPL-2.0.tar.gz, HypExp-2.0.tar.gz and MB/{MB.m,MBresolve.m,barnesroutines.m,README.md}
#               (optional, for machines without internet access: otherwise they are downloaded)
#             WOLFRAMSCRIPT=/path/to/wolframscript   GINSH=/path/to/ginsh   CMAKE=/path/to/cmake   JOBS=8

SHELL := /bin/bash
ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
OS := $(shell uname -s)
JOBS ?= 4

HF_SRC := $(ROOT)/dep/IntVolFLINT/src
HF_BIN := $(ROOT)/dep/IntVolFLINT/bin
HF_VERSION := 1.2.13
HPL := $(ROOT)/dep/HPL
TABLE_FILES := h9table.mat h10table.mat ms9_rules.mx mspm9_rules.mx ms10_rules_v2.mx mspm10_rules.mx
# the weight-9 and weight-10 HPL tables, gzipped, as assets of the GitHub release hpl-tables-v1
TABLES_URL ?= https://github.com/MBAnalytica/MBAnalytica/releases/download/hpl-tables-v1

# third-party packages that are not redistributed with MBAnalytica: make downloads them from their authors' pages,
# checks them against dep/UPSTREAM.sha256, unpacks the files below, applies dep/HPL/HPL.m.patch and checks the
# result against dep/UPSTREAM_FILES.sha256
DL := $(ROOT)/dep/.downloads
HPL_URL ?= https://www.physik.uzh.ch/data/HPL/HPL-2.0.tar.gz
HYPEXP_URL ?= https://www.physik.uzh.ch/data/HypExp/HypExp-2.0.tar.gz
MB_COMMIT := 5ddd820144c1e50c3e1d35f21ad6f0d167dbff20
MB_URL ?= https://gitlab.com/feynmanintegrals/MB/-/raw/$(MB_COMMIT)
HPL_FILES := HPL.m HPL_README HPLnolicense nmzv.m h6table.mat HPLatI1.m HPLatI2.m HPLatI3.m HPLatI4.m HPLatI5.m HPLatI6.m \
  numHPLatI4.m numHPLatI5.m numHPLatI6.m MinimalSet2.m MinimalSet3.m MinimalSet4.m MinimalSet5.m MinimalSet6.m \
  MinimalSetpm2.m MinimalSetpm3.m MinimalSetpm4.m MinimalSetpm5.m MinimalSetpm6.m
HYPEXP_FILES := HypExp.m README collectedfunctions.out listintegralsminimal.m rrarg.m rrlpnHPL_private.out2 rulesalgorithm.m \
  PZRule2.m PZRule3.m PZRule4.m PZRule5.m PZRule6.m PZRule7.m PZRule8.m PZRule9.m PZRule10.m
MB_FILES := MB.m MBresolve.m barnesroutines.m README.md

WOLFRAMSCRIPT ?= $(firstword $(shell command -v wolframscript 2>/dev/null) \
  $(wildcard /Applications/Wolfram.app/Contents/MacOS/wolframscript) \
  $(wildcard /Applications/Mathematica.app/Contents/MacOS/wolframscript))
GINSH ?= $(shell command -v ginsh 2>/dev/null)
CMAKE ?= cmake
PYTHON3 ?= $(shell command -v python3 2>/dev/null)

ifeq ($(OS),Darwin)
  BREW := $(shell command -v brew 2>/dev/null)
  OMP_ROOT := $(if $(BREW),$(shell brew --prefix libomp 2>/dev/null),)
  CMAKE_PLATFORM := -DCMAKE_CXX_COMPILER=/usr/bin/clang++ $(if $(OMP_ROOT),-DOpenMP_ROOT=$(OMP_ROOT),)
  MIMALLOC := $(if $(BREW),$(if $(shell brew --prefix mimalloc 2>/dev/null),ON,OFF),OFF)
  DEPS_COMMAND := brew install cmake flint gmp mpfr libomp mimalloc ginac python
else ifneq ($(shell command -v dnf 2>/dev/null),)
  CMAKE_PLATFORM :=
  MIMALLOC := OFF
  DEPS_COMMAND := sudo dnf install cmake gcc-c++ pkgconf-pkg-config patch gmp-devel mpfr-devel flint-devel ginac-utils python3
else
  CMAKE_PLATFORM :=
  MIMALLOC := OFF
  DEPS_COMMAND := sudo apt install cmake g++ pkg-config patch libflint-dev libgmp-dev libmpfr-dev ginac-tools python3-venv
endif

# the SHA-256 check of the HPL tables: shasum (macOS, Debian) or sha256sum (coreutils: RHEL, Fedora)
SHA256 := $(if $(shell command -v shasum 2>/dev/null),shasum -a 256,sha256sum)

# HyperFLINT needs FLINT >= 3.4; an older system FLINT (Ubuntu 24.04 ships 3.0) is replaced by a private build of
# FLINT $(FLINT_LOCAL_VERSION) inside the package folder
FLINT_MIN := 3.4
FLINT_LOCAL_VERSION := 3.6.0
FLINT_PREFIX := $(ROOT)/dep/IntVolFLINT/flint
SYSTEM_FLINT_OK := $(shell pkg-config --atleast-version=$(FLINT_MIN) flint 2>/dev/null && echo yes)
ifeq ($(SYSTEM_FLINT_OK),yes)
  FLINT_DEP :=
else
  FLINT_DEP := $(FLINT_PREFIX)/lib/pkgconfig/flint.pc
  export PKG_CONFIG_PATH := $(FLINT_PREFIX)/lib/pkgconfig:$(PKG_CONFIG_PATH)
endif

CMAKE_FLAGS := -DCMAKE_BUILD_TYPE=Release -DHF_VERSION=$(HF_VERSION) -DHF_LIBRARYLINK=OFF -DHF_OPENMP=ON \
  -DHF_MIMALLOC=$(MIMALLOC) $(CMAKE_PLATFORM)

.PHONY: all check deps upstream hyperflint python tables config test install uninstall benchmark clean

all: check upstream hyperflint python tables config
	@echo ""
	@echo "MBAnalytica is ready. Load it with  << \"$(ROOT)/MBAnalytica.wl\"  and run  make test  to check it."

# ---- tools -------------------------------------------------------------------------------------------------------

check:
	@missing=0; \
	if "$(CMAKE)" --version >/dev/null 2>&1; then echo "  found    cmake $$("$(CMAKE)" --version | head -1 | awk '{print $$3}')"; \
	else echo "  MISSING  cmake (or it does not run; set CMAKE=/path/to/cmake)"; missing=1; fi; \
	if command -v pkg-config >/dev/null 2>&1; then echo "  found    pkg-config"; else echo "  MISSING  pkg-config"; missing=1; fi; \
	if command -v patch >/dev/null 2>&1; then echo "  found    patch"; else echo "  MISSING  patch (the guarded HyperFLINT build applies a patch)"; missing=1; fi; \
	for lib in gmp mpfr; do \
	  if pkg-config --exists $$lib 2>/dev/null || [ -n "$$(ls /usr/include/$$lib.h /opt/homebrew/include/$$lib.h /usr/local/include/$$lib.h 2>/dev/null)" ]; \
	  then echo "  found    $$lib"; else echo "  MISSING  $$lib (development files)"; missing=1; fi; \
	done; \
	if [ "$(SYSTEM_FLINT_OK)" = "yes" ]; then echo "  found    flint $$(pkg-config --modversion flint)"; \
	elif [ -f "$(FLINT_PREFIX)/lib/pkgconfig/flint.pc" ]; then echo "  found    flint $(FLINT_LOCAL_VERSION) (private build in dep/IntVolFLINT/flint; the system FLINT is older than $(FLINT_MIN))"; \
	else echo "  note     the system FLINT is absent or older than $(FLINT_MIN): make builds FLINT $(FLINT_LOCAL_VERSION) in dep/IntVolFLINT/flint"; fi; \
	if [ -n "$(GINSH)" ]; then echo "  found    ginsh ($(GINSH))"; else echo "  MISSING  ginsh (GiNaC)"; missing=1; fi; \
	if [ -n "$(PYTHON3)" ]; then echo "  found    python3 ($(PYTHON3))"; else echo "  MISSING  python3"; missing=1; fi; \
	if [ -n "$(WOLFRAMSCRIPT)" ]; then echo "  found    wolframscript ($(WOLFRAMSCRIPT))"; \
	else echo "  MISSING  wolframscript (it comes with Mathematica; set WOLFRAMSCRIPT=/path if it is not on PATH)"; missing=1; fi; \
	if [ $$missing = 1 ]; then \
	  echo ""; echo "Install the missing system packages with:"; echo "  $(DEPS_COMMAND)"; \
	  echo "(or run  make deps CONFIRM=yes  to have make run that command)"; exit 1; fi

deps:
	@echo "The system packages MBAnalytica needs are installed with:"
	@echo "  $(DEPS_COMMAND)"
	@if [ "$(CONFIRM)" = "yes" ]; then $(DEPS_COMMAND); else echo "Run  make deps CONFIRM=yes  to run it."; fi

# ---- MB.m, MBresolve.m, the Barnes routines, HPL 2.0 and HypExp 2.0 (downloaded, not redistributed) --------------

upstream:
	@if cd "$(ROOT)/dep" && $(SHA256) -c UPSTREAM_FILES.sha256 > /dev/null 2>&1; then \
	  echo "  MB.m, MBresolve.m, Barnes routines, HPL 2.0 and HypExp 2.0 present and verified"; exit 0; fi; \
	mkdir -p "$(DL)/MB" "$(HPL)" "$(ROOT)/dep/HypExp" "$(ROOT)/dep/MB"; \
	fetch() { if [ -n "$(UPSTREAM)" ] && [ -f "$(UPSTREAM)/$$1" ]; then cp "$(UPSTREAM)/$$1" "$(DL)/$$1"; \
	  else echo "  downloading $$2"; curl -fsSL --retry 3 -o "$(DL)/$$1" "$$2"; fi; }; \
	fetch HPL-2.0.tar.gz "$(HPL_URL)" && fetch HypExp-2.0.tar.gz "$(HYPEXP_URL)" || exit 1; \
	for f in $(MB_FILES); do fetch "MB/$$f" "$(MB_URL)/$$f" || exit 1; done; \
	cd "$(DL)" && $(SHA256) -c "$(ROOT)/dep/UPSTREAM.sha256" > /dev/null || \
	  { echo "A download does not match dep/UPSTREAM.sha256; give local copies with UPSTREAM=/path"; exit 1; }; \
	rm -rf "$(DL)/x" && mkdir -p "$(DL)/x" && tar xzf HPL-2.0.tar.gz -C x && tar xzf HypExp-2.0.tar.gz -C x || exit 1; \
	for f in $(HPL_FILES); do cp "$(DL)/x/HPL-2.0/$$f" "$(HPL)/$$f" || exit 1; done; \
	for f in $(HYPEXP_FILES); do cp "$(DL)/x/HypExp-2.0/$$f" "$(ROOT)/dep/HypExp/$$f" || exit 1; done; \
	for f in $(MB_FILES); do cp "$(DL)/MB/$$f" "$(ROOT)/dep/MB/$$f" || exit 1; done; \
	patch -s "$(HPL)/HPL.m" < "$(HPL)/HPL.m.patch" || exit 1; \
	rm -rf "$(DL)/x"; \
	cd "$(ROOT)/dep" && $(SHA256) -c UPSTREAM_FILES.sha256 > /dev/null || \
	  { echo "The installed third-party files do not match dep/UPSTREAM_FILES.sha256"; exit 1; }; \
	echo "  MB.m, MBresolve.m, Barnes routines, HPL 2.0 and HypExp 2.0 downloaded and verified (HPL.m patched)"

# ---- HyperFLINT: the plain build, and the guarded build with dep/IntVolFLINT/patches applied -----------------------

hyperflint: $(HF_BIN)/hyperflint $(HF_BIN)/hyperflint_guarded

$(FLINT_PREFIX)/lib/pkgconfig/flint.pc:
	@echo "Building FLINT $(FLINT_LOCAL_VERSION) in $(FLINT_PREFIX) (the system FLINT is older than $(FLINT_MIN)) ..."
	mkdir -p "$(FLINT_PREFIX)/src"
	curl -fsSL --retry 3 -o "$(FLINT_PREFIX)/src/flint.tar.gz" \
	  "https://github.com/flintlib/flint/releases/download/v$(FLINT_LOCAL_VERSION)/flint-$(FLINT_LOCAL_VERSION).tar.gz"
	tar xzf "$(FLINT_PREFIX)/src/flint.tar.gz" -C "$(FLINT_PREFIX)/src"
	cd "$(FLINT_PREFIX)/src/flint-$(FLINT_LOCAL_VERSION)" && ./configure --prefix="$(FLINT_PREFIX)" > "$(FLINT_PREFIX)/build.log" 2>&1 && \
	  $(MAKE) -j $(JOBS) >> "$(FLINT_PREFIX)/build.log" 2>&1 && $(MAKE) install >> "$(FLINT_PREFIX)/build.log" 2>&1 || \
	  { tail -20 "$(FLINT_PREFIX)/build.log"; exit 1; }
	rm -rf "$(FLINT_PREFIX)/src"
	@echo "  FLINT $(FLINT_LOCAL_VERSION) built"

$(HF_BIN)/hyperflint: $(FLINT_DEP)
	@echo "Building HyperFLINT $(HF_VERSION) (IntVolFLINT fork) ..."
	"$(CMAKE)" -S "$(HF_SRC)" -B "$(HF_SRC)/build" $(CMAKE_FLAGS) -DHF_BUILD_VARIANT=mbanalytica > "$(HF_SRC)/build.log" 2>&1 || \
	  { tail -20 "$(HF_SRC)/build.log"; exit 1; }
	"$(CMAKE)" --build "$(HF_SRC)/build" --target hyperflint-cli -j $(JOBS) >> "$(HF_SRC)/build.log" 2>&1 || \
	  { tail -20 "$(HF_SRC)/build.log"; exit 1; }
	mkdir -p "$(HF_BIN)"
	cp "$(HF_SRC)/build/hyperflint" "$(HF_BIN)/hyperflint"
	@"$(HF_BIN)/hyperflint" --version 2>/dev/null | grep -q "HF_VERSION" && echo "  HyperFLINT built: $(HF_BIN)/hyperflint"

$(HF_BIN)/hyperflint_guarded: $(FLINT_DEP)
	@echo "Building the guarded HyperFLINT (transform_nonlinear_guard.patch) ..."
	rm -rf "$(HF_SRC)/build-guarded-src" && mkdir -p "$(HF_SRC)/build-guarded-src"
	cd "$(HF_SRC)" && tar cf - --exclude './build*' . | (cd build-guarded-src && tar xf -)
	cd "$(HF_SRC)/build-guarded-src" && patch -p1 -s < "$(ROOT)/dep/IntVolFLINT/patches/transform_nonlinear_guard.patch"
	"$(CMAKE)" -S "$(HF_SRC)/build-guarded-src" -B "$(HF_SRC)/build-guarded" $(CMAKE_FLAGS) -DHF_BUILD_VARIANT=mbanalytica-guarded \
	  > "$(HF_SRC)/build-guarded.log" 2>&1 || { tail -20 "$(HF_SRC)/build-guarded.log"; exit 1; }
	"$(CMAKE)" --build "$(HF_SRC)/build-guarded" --target hyperflint-cli -j $(JOBS) >> "$(HF_SRC)/build-guarded.log" 2>&1 || \
	  { tail -20 "$(HF_SRC)/build-guarded.log"; exit 1; }
	mkdir -p "$(HF_BIN)"
	cp "$(HF_SRC)/build-guarded/hyperflint" "$(HF_BIN)/hyperflint_guarded"
	rm -rf "$(HF_SRC)/build-guarded-src"
	@echo "  guarded HyperFLINT built: $(HF_BIN)/hyperflint_guarded"

# ---- Python environment of the u-dependent Subtraction route -----------------------------------------------------

# only the Subtraction method with kinematic variables needs it; a Python that already has numpy, scipy and sympy
# (PYTHON=/path, or python3 itself) is used as it is, otherwise make creates .venv; a failure here is only a warning
PYTHON ?=
PY_PACKAGES := import numpy, scipy, sympy

python:
	@if [ -n "$(PYTHON)" ] && "$(PYTHON)" -c "$(PY_PACKAGES)" 2>/dev/null; then \
	  echo "$(PYTHON)" > "$(ROOT)/.python"; echo "  Python: $(PYTHON) (numpy, scipy, sympy present)"; \
	elif [ -x "$(ROOT)/.venv/bin/python3" ] && "$(ROOT)/.venv/bin/python3" -c "$(PY_PACKAGES)" 2>/dev/null; then \
	  echo "$(ROOT)/.venv/bin/python3" > "$(ROOT)/.python"; echo "  Python environment present: $(ROOT)/.venv"; \
	elif "$(PYTHON3)" -m venv "$(ROOT)/.venv" >/dev/null 2>&1 && \
	     "$(ROOT)/.venv/bin/pip" install --quiet -r "$(ROOT)/src/MB2MPL/parameter_support/requirements.txt"; then \
	  echo "$(ROOT)/.venv/bin/python3" > "$(ROOT)/.python"; echo "  Python environment ready: $(ROOT)/.venv"; \
	elif [ -n "$(PYTHON3)" ] && "$(PYTHON3)" -c "$(PY_PACKAGES)" 2>/dev/null; then \
	  rm -rf "$(ROOT)/.venv"; echo "$(PYTHON3)" > "$(ROOT)/.python"; \
	  echo "  Python: $(PYTHON3) (numpy, scipy, sympy present; no .venv needed)"; \
	else \
	  rm -rf "$(ROOT)/.venv"; echo "" > "$(ROOT)/.python"; \
	  echo "  WARNING: no Python with numpy, scipy and sympy, and .venv could not be created."; \
	  echo "  Only the Subtraction method with kinematic variables needs it. Install python3-venv, or give PYTHON=/path."; \
	fi

# ---- the weight-9 and weight-10 HPL tables (too large for git) ---------------------------------------------------

tables:
	@for f in $(TABLE_FILES); do \
	  if [ -f "$(HPL)/$$f" ]; then continue; fi; \
	  if [ -n "$(TABLES)" ] && [ -f "$(TABLES)/$$f" ]; then cp "$(TABLES)/$$f" "$(HPL)/$$f"; \
	  elif [ -n "$(TABLES)" ] && [ -f "$(TABLES)/$$f.gz" ]; then gunzip -c "$(TABLES)/$$f.gz" > "$(HPL)/$$f" || exit 1; \
	  elif [ -n "$(TABLES_URL)" ]; then echo "  downloading $$f.gz"; \
	    curl -fL --retry 3 -o "$(HPL)/$$f.gz" "$(TABLES_URL)/$$f.gz" && gunzip -f "$(HPL)/$$f.gz" || exit 1; \
	  else echo "The HPL table $$f is missing. Give the folder that holds it: make TABLES=/path"; exit 1; fi; \
	done
	@cd "$(HPL)" && $(SHA256) -c "$(ROOT)/dep/HPL_TABLES.sha256" > /dev/null && echo "  HPL weight 9 and 10 tables present and verified"

# ---- config.m: the paths found on this machine, read by MBAnalytica.wl and by every worker ------------------------

config:
	@{ echo "(* written by make on $$(date '+%Y-%m-%d %H:%M'); run make config to refresh it *)"; \
	   echo "<|"; \
	   echo "  \"Ginsh\" -> \"$(GINSH)\","; \
	   echo "  \"HyperFLINT\" -> \"$(HF_BIN)/hyperflint\","; \
	   echo "  \"HyperFLINTGuarded\" -> \"$(HF_BIN)/hyperflint_guarded\","; \
	   echo "  \"Python\" -> \"$$(cat "$(ROOT)/.python" 2>/dev/null)\","; \
	   echo "  \"RISCPath\" -> \"$(RISC)\","; \
	   echo "  \"WolframScript\" -> \"$(WOLFRAMSCRIPT)\""; \
	   echo "|>"; } > "$(ROOT)/config.m"
	@echo "  config.m written"

# ---- tests -------------------------------------------------------------------------------------------------------

test:
	@if [ -z "$(WOLFRAMSCRIPT)" ]; then echo "wolframscript not found; set WOLFRAMSCRIPT=/path/to/wolframscript"; exit 1; fi
	"$(WOLFRAMSCRIPT)" -file "$(ROOT)/tests/InstallTest.wls"

benchmark:
	@if [ -z "$(WOLFRAMSCRIPT)" ]; then echo "wolframscript not found; set WOLFRAMSCRIPT=/path/to/wolframscript"; exit 1; fi
	"$(WOLFRAMSCRIPT)" -file "$(ROOT)/tests/benchmark/run_regression.wls"

# ---- $Path entry in Mathematica's init.m -------------------------------------------------------------------------

install:
	@"$(WOLFRAMSCRIPT)" -code 'f = FileNameJoin[{$$UserBaseDirectory, "Kernel", "init.m"}]; \
	  line = "If[!MemberQ[$$Path, \"$(ROOT)\"], AppendTo[$$Path, \"$(ROOT)\"]] (* MBAnalytica *)"; \
	  old = If[FileExistsQ[f], Import[f, "Text"], ""]; \
	  If[StringContainsQ[old, "(* MBAnalytica *)"], Print["already installed"], \
	    Quiet[CreateDirectory[DirectoryName[f]]]; Export[f, old <> "\n" <> line <> "\n", "Text"]; \
	    Print["added $(ROOT) to $$Path in ", f]]'

uninstall:
	@"$(WOLFRAMSCRIPT)" -code 'f = FileNameJoin[{$$UserBaseDirectory, "Kernel", "init.m"}]; \
	  If[FileExistsQ[f], lines = StringSplit[Import[f, "Text"], "\n"]; \
	    Export[f, StringRiffle[Select[lines, ! StringContainsQ[#, "(* MBAnalytica *)"] &], "\n"] <> "\n", "Text"]]; \
	  Print["removed the MBAnalytica line from ", f]'

clean:
	rm -rf "$(HF_SRC)/build" "$(HF_SRC)/build-guarded" "$(HF_SRC)/build-guarded-src" "$(HF_SRC)"/build*.log "$(FLINT_PREFIX)" \
	  "$(HF_BIN)" "$(ROOT)/.venv" "$(ROOT)/.python" "$(ROOT)/config.m"
	cd "$(HPL)" && rm -f $(TABLE_FILES) $(HPL_FILES)
	cd "$(ROOT)/dep/HypExp" && rm -f $(HYPEXP_FILES)
	cd "$(ROOT)/dep/MB" && rm -f $(MB_FILES)
	rm -rf "$(DL)"
