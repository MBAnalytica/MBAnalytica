# level6_tables — sixth-root-of-unity MPL reduction tables (weights 1-4)

Source: J.M. Henn, A.V. Smirnov, V.A. Smirnov, "Evaluating multiple polylogarithm values at sixth roots of unity up
to weight six", Nucl. Phys. B 919 (2017) 315, arXiv:1512.08389.  Files downloaded 2026-09-05 from
http://theory.sinp.msu.ru/~smirnov/mpl6/mpl6.tar.gz (284 MB; only the weight<=4 files are kept here; weights 5-6 are
13 MB / 550 MB each and not needed).

Notation (README.txt): GR[a1,...,aw] / GI[a1,...,aw] = real / imaginary part of G(a1,...,aw;1) with letters
{0, r1, r3, -1, r4, r2, 1}, r1 = e^{i pi/3}, r2 = e^{-i pi/3}, r3 = e^{2 i pi/3}, r4 = e^{-2 i pi/3}; a1 != 1.
sl<w>re.m / sl<w>im.m = substitution lists reducing every weight-w GR/GI to the basis irRe[w] / irIm[w] (irRe.m,
irIm.m); maptores4000*.txt = 4000-digit values of the basis elements.  GI[r2] = -Pi/3, GR[-1] = Log[2],
GR[0,0,1] = -Zeta[3].

Status of the relations: the paper (Sec. 3) derives shuffle, stuffle, regularization, distribution and conjugation
relations exactly; for N = 6 these are NOT complete (Zhao's Conjecture 9.3), and the authors removed the remaining
dependent elements with PSLQ at 4000 digits (weight 4: 2 real and 6 imaginary elements).  The tables are therefore
package-level knowledge of the same standing as the MZV data mine and PolyLogTools' own sixth-root tables (which stop
at weight 3): used here to reduce sixth-root constants that cancel in MB13's pure-MZV coefficients; the exact
per-order benchmark assembly remains the arbiter.
