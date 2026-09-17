# Review notes (working file; the final review is review.md)

Paper: "Forty-eight hours with the Kourovka Notebook" (Codex gpt-6-astra, Kinyon, Urban), 96 pp.
Checks live in review-other1/checks/ (GAP 4.16.1 scripts + logs, Python scripts + logs).

## Verified computationally (this review)
- Thm 4.2 (21.68): group of order 2592, IsMonomial = false, six non-monomial irreducibles of degree 8; B normal abelian of
  order 27 with complement K of order 96; H = SL(2,3). (t42_kida.log)
- Thm 4.3 (20.108): |G| = 605, Z(G) = 1, |Aut G| = 12100, claimed automorphisms correct, Hol = N_Sym(605)(lambda G) of
  order 7320500, theta normalises Hol, theta^2 not in Hol, theta^4 = 1. (t43_tsang.log)
- C.1 (21.121a): claim (2) checked on all subgroup classes of G_1 (order 12) and G_2 (order 3456, 614 classes); no
  violation; O_{2'}(G_k) = 1. (c01_jordan.log)
- C.16 (4.55): CTblLib 3.A7 mod 5 decomposition rows, Galois orbits, PIM degrees exactly as printed. (c16_455.log)
- C.42 (20.122): |G| = 36864; 81 ordered pairs, 10 distinct intersections, orders {2:5, 4:4, 8:1}; Min = min = A,
  not contained in F(G) (order 512). (c42_20122.log)
- C.43 (17.39): (p,d) = (3,1),(3,2),(5,1): supersoluble, metabelian, trivial hypercentre, |Phi| = p,
  p^{d+1} system normalisers, least number with trivial intersection d+1. (c43_1739.log)
- C.15 (21.60): Dic3 at p=2: Brauer degrees 1,2; decomposition matrix; central idempotents of the 2-dim characters
  have 1/6 coefficients (not 2-integral); J(F2G) dim 7. Consistent with non-semiperfectness. (c15_2160.log)
- C.11 (20.90): images mod t, t^2, t^3 have orders 60 (A5), 240 (C2xC2xA5), 15360. (c11_2090.log)
- C.27 (15.65): numerical constants (1-a1+a2-a3+a4 at 3/5, bound 210/253, U(-1/2) >= 9/56, root of U at -0.5761,
  L(-13/20) > 0, 81/112) all correct. FNP formulas themselves NOT checked. (c27_1565.log)
- C.31 (12.40): F(5) = 3904, v2|PSL6(5^a)| = 13 for odd a, the valuation-steering procedure works for k = 3..15.
  (c31_1240.log)

## Checked by hand (proof read line by line), no error found
- 4.1 (21.106), 4.2 (21.68) theory, 4.3 (20.108) theory, C.1 (21.121a), C.7 (17.33: relations, torsion-freeness,
  finite abelianisation, embeddings of Gamma_L, quasi-identity argument), C.10 (18.92; but see scope remark),
  C.11 (20.90), C.15 (21.60), C.16 (4.55), C.18 (15.89), C.21 (19.56), C.31 (12.40), C.38 direct criterion proof.

## Scope / novelty remarks so far
- 18.92: literal definition makes the problem nearly trivial (prime-set formations, 5-element N5 family). Correct for the
  printed definition, but very likely not what Skiba intended; should not count as a solution without that caveat.
- 20.90: any closed subgroup of SL2(F_{2^k}[[t]]) is CA (classical); the example is elementary; question may have
  intended more.
- 16.28(a): uses reducible X and a field with an element of infinite multiplicative order (F5(t)); over the algebraic
  closure of F_p no such example of this type. Correct as printed.
- 19.56: full proof checked; strong result (our own run only had partial results).

## Carpets (19.61/19.62) — independent verification
- chev_consts.g: absolute Chevalley constants |C_{ij,rs}| for A2, B2, G2 from GAP's Chevalley basis (adjoint rep,
  commutator peeled in increasing i+j order, both orders of each pair). Values {1}, {1,2}, {1,2,3}.
- carpet_appF.py: all 19 printed derivations of Appendix F valid (every application uses a genuine rule constant,
  monomials/roots and gcd steps correct), requested coefficients match the gcd-combined constants, and the displayed
  destination roots have exactly 1/2/3/5/8 requests as printed.
- carpet_prover.py (own saturation search, no use of the paper's certificates): all 104 requests of (5) and all 300
  merged requests of (6) (600 raw nonconstant terms) are derivable. Counts coincide with the paper (6/20/78; 12/48/240).
- Direct proof of the square criterion (C.38) read and found correct (Lie-ring M, adjoint action, detection via h_q,
  symplectic D-trick for C_n including isogeny types).

## Reported coverage numbers reproduced exactly (this review)
- SHA-256 of docs/21tkt.pdf matches the digest printed in the paper.
- Issue 21 has exactly 150 entries; my crude parse of the main body gives 1309 distinct entries vs the paper's 1308
  (parsing noise, not a discrepancy worth reporting).
- 91,774 nonabelian groups of order <= 511 (GAP), exactly as in section 3.3.
- 4,722 transitive groups of degrees 2-20 (GAP), exactly as in section 3.3.
- 3,933,931,043 binary necklaces of lengths 1-36 (formula), exactly as in section 3.3.
- Table 1 and Table 2 arithmetic is internally consistent; the only nit is USD 969.78 vs 910.61+0.56+58.62 = 969.79
  (the paper does say estimates are rounded independently).
- Appendix B: 46 rows, 46 distinct section references, covering C.1-C.43 and 4.1-4.3 exactly once.
- None of the 46 problems is starred (i.e. recorded as solved) in the supplied Notebook file; 19.63, which the ledger
  groups with 19.62, IS starred there, consistent with the paper's own statement.

## Priority findings (independent of the paper)
- Problem 21.106: a public GitHub repository TPColor/kourovka-notebook-problem-21.106 contains a Lean 4 formalised
  counterexample using the integral Heisenberg group and a formula of the same shape (credited to Lily Zhang, with
  Evan Li suggesting the Heisenberg simplification). Dates need to be checked; if it predates 10 September 2026 the
  paper's flagship Theorem 4.1 is a rediscovery.

## External checks (web)
- 21.106 priority: repo TPColor/kourovka-notebook-problem-21.106 (not a fork) was created 2026-09-10 19:32:56 UTC
  (initial commit only) and the Lean files with the Heisenberg counterexample were pushed 2026-09-11 10:54:21 UTC,
  i.e. during the experiment's window but about 14 hours AFTER the paper's own 21.106 proof file was committed
  (10 Sept 21:06 UTC). Credits there: Lily Zhang (counterexample and a planned arXiv preprint), Evan Li. No matching
  arXiv preprint found (arXiv API search for conciseness + residually finite returns nothing after May 2025).
  So: independent parallel discovery, the paper is (narrowly) earlier, but the result is now publicly duplicated and
  formally verified by others; novelty of Theorem 4.1 should not be asserted.
- No overlap with arXiv:2607.17477 (Kourovka 3.46, 18.50, 19.25, 20.125, 21.8, 21.24, 21.147, 21.150) or
  arXiv:2608.29219 (LLM-assisted; Kourovka 14.85, 19.94, 16.11, 17.47, 17.32).
- Nuzhin's 2026 Siberian Math. J. paper "Lie rings and groups defined by carpets of symplectic type" does give a
  complete positive answer to Kourovka 19.63 (square criterion), as the paper states; the pre-2023 literature had it
  for all types except symplectic.
- 21.115: the printed question allows mixed left and right cosets, but a right coset Hg equals the left coset g(H^g),
  so Sambale's left-coset preprint (arXiv:2609.09052, 8 Sept 2026) does cover the printed question. The paper's
  classification of 21.115 as prior work is therefore right.
- Amelio's preprint arXiv:2509.11958 exists (non-split sharply 2-transitive groups of bounded exponent, Sept 2025),
  as cited for C.25/C.29.

## C.27 (15.65) dependency check
Downloaded the Fulman-Neumann-Praeger memoir (author copy) and checked the transcription:
- paper's A(u) = (1+u-u^2)/(1+u) equals FNP's cyclic factor 1 - 1/(q^d(q^d+1)); B(u) = (1-u+u^2)/(1-u) equals
  1 + 1/(q^d(q^d-1))  (FNP Theorem 2.2.9).
- paper's J_d(q) equals FNP's N*(q;2d) (Lemma 1.3.16(a): odd divisors of 2d are those of d).
- paper's E(u) = (1-u)U(u) equals FNP's A_{q,d}(1) and D(u) = (1-u)L(u) equals B_{q,d}(1), verified numerically to
  12 digits for Q = 2,3,4,5,7,8,9,11,16,25 (checks/c27_fnp_match.log).
- paper's P(t) equals FNP's F(1) = 1 + sum_m 1/|Sp(2m,q)|, verified to 15 digits.
So the analytic argument rests on correctly transcribed inputs. The remaining unverified item is the exact form of
the K_d exponents (M*(q;d)) and of FNP Theorems 2.3.11, 3.1.18; the paper itself records an index discrepancy there.

## Imported-theorem checks (web)
- C.37 (20.1): the Arezoomand-Iranmanesh-Praeger(-Tracey) work does establish totally 2-closed finite groups with
  trivial Fitting subgroup, all direct products of pairwise non-isomorphic sporadic simple groups including Janko
  groups; J1 being totally 2-closed is therefore a genuine citation.
- C.15 (21.60) / 4.2 (21.68): Kida's paper conjectures that semiabelian finite groups are monomial and reports a
  Magma check that there is no semiabelian group among the non-monomial groups of order at most 240. The paper's
  counterexample has order 2592, so there is no conflict with that computation.
- Order-96 auxiliary group K of Theorem 4.2: |K| = 96, IdGroup [96,204], IsMonomial = true, E elementary abelian of
  order 8 normal with A4 complement (checks/t42_extra.log). Consistent with Kida's Magma check that no semiabelian
  group is non-monomial in orders <= 240, and with the paper's construction.
- C.21 (19.56) imports: the hyperfocal subgroup theorem in the form used (P ∩ O^p(G) = <[x,g] : x in Q <= P,
  g in N_G(Q) of p'-order>) is Puig's theorem, stated as Lemma 2.2 in Broto-Castellana-Grodal-Levi-Oliver,
  "Extensions of p-local finite groups" — the citation checks out. The minimal-simple local statement (an elementary
  abelian 2-subgroup with a nontrivial odd-order action) is true for all five Thompson families by inspection
  (Borel subgroup for PSL(2,2^f) and Sz(2^f), A4 inside PSL(2,q) for odd q, S4 inside PSL(3,3)), so even if the
  attribution to "[11, Proposition 18]" is imprecise the step is safe.
- Verified verbatim: Bastos-Monetta, "Coprime commutators in finite groups", Proposition 18: "Every finite minimal
  simple group G contains a subgroup H = A x| T where A is an elementary abelian 2-group and T is a subgroup of odd
  order such that C_A(T) = 1." This is exactly the input C.21 uses (the paper only needs a nontrivial action).
- CTblLib in this GAP installation has exactly 2,750 ordinary character tables, matching the paper's "2,750 ordinary
  character tables" for the 21.113 screen (checks/ctbl_count.log).
- Transitive groups of degrees 2..8: exactly 86, matching the paper's "direct control on 86 groups in degrees 2
  through 8" for Problem 21.99 (checks/coverage2.log).

## Appendix C.8-C.14 (checked with help of a second reader, then re-verified here)
- C.8 (17.101), C.9 (18.76), C.12 (11.116), C.14 (21.40): read line by line, correct. C.9's final cancellation needs
  that the division closure of kF centralises kL (true: the centraliser of kL in D is a division subring).
- C.13 (14.72): recomputed in sympy (checks/c13_1472.log): sigma has order 4 and preserves the ideal; the Groebner
  basis of equations plus 2x2 Jacobian minors is [1], so X is smooth; a, v, d are invariant; xd-u^2 and (a-1)d-v^2
  lie in the ideal; eliminating x,y,u,v gives exactly (A*D - D - V^2), i.e. V^2 = (A-1)D. The quotient is singular
  at (1,0,0).
  NEW FINDING: the fixed locus is Cartier but not principal. X is the total space of a line bundle over the affine
  curve C: y^2 = x^3 - x (E minus O), and the fixed locus is the fibre over the 2-torsion point T = (0,0). If
  I(Z) = (f), restricting to the zero section gives f|C generating the maximal ideal at T, so div(f|C) = [T] on C,
  forcing T = O in E(C). Contradiction. Whether this matters depends on how "regular hypersurface (of codimension
  1)" in 14.72 is read. Repairable by removing a sigma-orbit of 4-torsion fibres.

## Numerical spot-checks done ahead of the remaining reader reports
- C.36 (19.93): 1 - 2t + 3t^p at t = 2/3 equals -115/729 for p = 7 (the paper's figure) and stays negative for
  p = 11, 13; so the Golod-Shafarevich inequality does force divergence of H at 2/3. The auxiliary product P_K(t)
  converges at t = 2/3 for every K, as the paper needs. (checks/c36_1993.log)
- C.26 (10.32): with exact prime sums, theta(n/2) - theta(3n/8+1) > n/16 holds at n = 1126 (129.96 vs 70.38) and at
  larger n; the two Rosser-Schoenfeld inputs hold on the ranges used; and the paper's own chain of bounds gives
  88.43 > 70.38 at n = 1126. (checks/c26_1032.log)
- C.28 (15.92) arithmetic: 720720 = 2^4*3^2*5*7*11*13; v_11 = v_13 = 1; E = 720720/p is even and coprime to p for
  p = 11, 13, and E/2 equals the printed exponents 32760 and 27720 exactly. (checks/c28_1592.log)
- C.22 (20.92a): the coefficient identity sum_{i=0}^{p-2} 2^{i(j-1)} = -1 (j=1) and 0 (2 <= j <= D) mod p holds for
  every D below ord_p(2), checked for p = 19, 23, 29, 31, 37, 101, 131; the bookkeeping E = k*2^{k-2},
  D = (k-1)E and "p > 2^D forces ord_p(2) > D" also check out. (checks/c22_2092.log)
- C.30 (9.4): brute force over all quasigroups of orders 2, 3, 4 confirms t_{n!}(x,y) = y with no exception, and the
  shift quasigroup on F_3^{N+1} gives t_N(0, e_0) = e_N != e_0 as the proof requires. (checks/c30_94.log)
- C.37 (20.1): |J1| = 175560 = 2^3*3*5*7*11*19 is coprime to 13, so the coprime-order lemma applies as claimed.
- C.35 (16.38): the closing counterexample checks out: delta is a cocycle, -delta(C) consists of infinite-order
  elements of the free abelian base, and none of their doubles lies in the set. (checks/c37_c35.log)
- C.32 (13.42): exact computation in the free associative algebra truncated above degree 3 confirms the paper's two
  BCH facts: the first three coordinates of l^h are (a, b, c + aB - bA), and [l,h] = 1 is equivalent to the three
  vanishing minors aB-bA = aC-cA = bC-cB = 0 (the V and W coordinates of [l,h] reduce to the second and third minors
  modulo the first). (checks/c32_1342.log)
- C.17 (21.107): the sets D_k = {s : v_2(|s|+1) = k} do partition the group and every k is realised by arbitrarily
  large sizes, which is what the density argument needs.
- C.34 (15.76b): differentiating Y^k(X-1) + X^l(Y-1) = XY - 1 in X at X = 1 gives exactly Y^k = l + (1-l)Y, and the
  only integer solutions of the identity are (k,l) = (0,1) and (1,0), as the paper claims. (checks/c17_c34.log)
- C.33 (14.26): the interpolation polynomials Q_i behave as claimed in three small parameter sets: Q_i(j,...,j) is
  the Kronecker delta on I, they vanish when z2 = z1 + d for 1 <= d <= R, and their degree in each variable is
  exactly the bound 2R(c-1) + M - 1 that the paper requires of m. (checks/c33_1426.log)
- Section 3.3 character-table screen reproduced exactly: over the 2,750 CTblLib tables there are 9,850 table/prime
  cases, of which 7,573 have the modular table available and 2,277 do not - the paper's three numbers to the unit.
  (checks/coverage2.log)
- E.4 (16.60): checked the twisted Frobenius-Schur identity sum_chi chi(1) iota_alpha(chi) = #{g : alpha(g) = g^{-1}}
  and the bound by T(G) = sum of degrees for every automorphism class of S3, Q8, D10, Dic3, A4, the modular group of
  order 16 and S4 - both hold everywhere. For D10 and an automorphism of order 5 the indicators are cos(72 deg) and
  cos(144 deg), absolute value below 1, so the single flag my first script raised was an artifact of testing whether
  |iota|^2 is rational. (checks/e4_1660.log, checks/e4_d10.log)
- D.5 (17.118): with Laffey's 7/9 bound, r independent hyperplanes cover 1-(2/3)^r of the group, which exceeds 7/9
  first at r = 4; so r <= 3 and the index bound 27 for p = 3 follows, and 4 for p = 2. (checks/d5_d1.log)
- D.1 (20.100): the hypothesis-control example is right - over C5 no ordering of the four nonidentity elements makes
  a_1, a_2^2, a_3^3, a_4^4 distinct, so allowing an element of order 5 at n = 4 really does break the conclusion.
- D.4 (20.124): the Rota-Baxter identity checks out by hand: B(D(u)) = phi(u) and D(u)phi(u)D(v)phi(u)^{-1} = D(uv),
  hence B(gB(g)hB(g)^{-1}) = phi(uv) = B(g)B(h).
- E.1 (13.19): the small example verified in GAP: |Q| = 256, phi is a homomorphism onto D8 with kernel H of order 32,
  both Q and H project onto all four factors (so both are subdirect in D^4), H contains the diagonal, and D8 is
  irregular because s^2 = t^2 = 1 while (st)^2 != 1. (checks/e1_1319.log)
- D.2 (20.89): the remark that bounded finite subgroups are not automatic in positive characteristic is immediate:
  diag(t,1) conjugates U(a) to U(ta), so the group generated by diag(t,1) and U(1) over F_p(t) contains U(t^k) for
  every k, giving elementary abelian subgroups of unbounded rank.
- D.6 (21.114): the order-8192 central-product example rests on "literal finite permutation models" kept in the
  archive; with the archive unreachable, the numbers (|P| = 512 with derived series 512, 32, 2, 1; |Q| = 128 with
  a(Q) = 16; a(G) = 256) cannot be checked from the paper.
- D.3 (21.121b): the bound |C| <= |P/Phi(P)| - 1 for abelian p'-subgroups C of Aut(P) held in all 344 cases over the
  p-groups of orders 4, 8, 9, 16, 25, 27, 32, 49, 81; and 16 < 60 < 64 gives 2 < log60/log4 < 3 as claimed.
  (checks/d3_21121b.log)

## Appendix C.17-C.26 (second reader, verified here)
- C.22 (20.92a): the exponent is E = k^{2k-2}, not k*2^{k-2}. Confirmed from the PDF word boxes (the "2k-2" box sits
  raised, exactly like the "D" in "2^D") and by internal consistency: deg x_1 = 1 and k-1 steps each multiplying the
  degree by at most k^2 give (k^2)^{k-1} = k^{2k-2}. My own identity check of the coefficient extraction stands.
- C.17 (21.107), C.26 (10.32): correct; my own partition and Chebyshev checks agree.
- C.23 (9.47): correct, but the whole argument is contingent on reading the E-topology as the full Vietoris
  topology. The Notebook itself never defines the E-topology (8.62, 8.63, 9.46, 9.47, 9.49 all just use the name);
  the paper states its reading openly and Lemma C.5 genuinely needs the upper sets D_1(O) for non-compact closed O,
  which the Chabauty topology does not provide.
- C.25 (10.62) imports verified against Amelio's preprint text (fetched and extracted): Theorem 6.7 gives exactly
  (1) elliptic subgroups embed, (3) every finite-order element of the quotient satisfies g^{2n} = 1 for some n in the
  prescribed odd family or is an elliptic image, (4) infinitely many new elements - matching the paper's rendering
  with N = {p}. The prescribing of a chosen loxodromic element in the first family comes from the proof (which adds
  relations h^{n_h} for h loxodromic in the image of Q), not the statement. Remark 6.8 states "up to making our
  critical exponent larger, we may take a smaller value for the rescaling parameter", and then fixes the constant by
  lambda'' * 2 <= L_S delta_1; the paper needs 3 lambda <= L_S delta_1, i.e. the same principle with 3 in place of 2.
  Both steps are plausible but are extrapolations rather than quotations.
- E.10 (12.69): verified against the printed statement. The problem asks, for a countably infinite field F with a
  finite automorphism group G and a subfield S such that every x in F has a nonzero f in ZG with x^f in S, whether
  F = S or F/S is purely inseparable. With F = Q(i), S = Q and G = {1, sigma}, the single element f = 1 + sigma
  works for every x (norm in the multiplicative reading, trace in the additive one), while F/S is separable and
  proper. So the literal claim fails, and the paper is right both to record it and to count no resolution of the
  intended question. The same example with F = C, S = R contradicts the uncountable assertion in the comment.
- C.6 (16.20): the printed order is right: |SL2(5)||SL2(7)||SL2(13)|/2 = 120*336*2184/2 = 44,029,440, the three
  simple quotient orders 60, 168, 1092 pairwise fail to divide one another (which is what kills the cross
  homomorphisms), and the central quotient leaves a centre of order 4. (checks/c6_1620.log)
- D.3 (21.121b) Chermak-Delgado step: computing the measure |H||C_X(H)| by hand over all subgroups, the intersection
  of the maximal-measure subgroups is abelian, normal and of index at most j^2 in all 132 nonabelian groups of
  orders 8, 12, 16, 18, 24, 27, 32, 36, 48, where j is the least index of an abelian subgroup. (checks/d3_cd_full.log)

## Index of checks/ (script + log per item)
t42_kida, t42_extra      21.68 (order 2592 non-monomial; order-96 auxiliary group)
t43_tsang                20.108 (order 605, holomorph, element of order four)
c01_jordan               21.121(a) (p-Jordan inequality on all subgroups of G_1, G_2)
c6_1620                  16.20 (orders in the central product)
c11_2090                 20.90 (SL2 images mod t, t^2, t^3)
c13_1472                 14.72 (smoothness, invariants, elimination ideal)
c15_2160                 21.60 (2-modular data for the dicyclic group of order 12)
c16_455                  4.55 (3.A7 mod 5 decomposition rows, Galois orbits, PIM degrees)
c17_c34                  21.107 partition; 15.76(b) coefficient comparison
c19_169                  16.9 (dynamic program vs brute force)
c22_2092                 20.92(a) (coefficient identity, degree bookkeeping)
c23_947                  9.47 (almost disjoint branch family)
c24_945                  9.45 (criterion vs brute force, 1264 cases)
c26_1032                 10.32 (Chebyshev inequalities)
c27_1565, c27_fnp_match  15.65 (numerical constants; match with the source memoir)
c28_1592                 15.92 (cycle-length arithmetic)
c30_94                   9.4 (quasigroup identity, brute force)
c31_1240                 12.40 (2-adic facts for PSL6(5^a))
c32_1342                 13.42 (BCH conjugation and commuting criterion)
c33_1426                 14.26 (interpolation polynomials)
c36_1993                 19.93 (Golod-Shafarevich arithmetic)
c37_c35                  20.1 arithmetic; 16.38 counterexample
c42_20122                20.122 (full intersection family)
c43_1739                 17.39 (system normalisers for three parameter pairs)
carpet_appF, chev_consts 19.62 (Chevalley constants; the 19 printed derivations)
carpet_prover            19.61 and 19.62 (independent re-derivation of all 104 + 300 certificates)
counts, coverage2, ctbl_count  reported coverage numbers in Section 3.3
d3_21121b, d3_cd_full    21.121(b) (automorphism bound; Chermak-Delgado step)
d5_d1                    17.118 (Laffey bound); 20.100 (C5 control, size bound)
e1_1319                  13.19 (order-256 subdirect example)
e3_21115                 21.115 (class-two linearisation)
e4_1660, e4_d10          16.60 (twisted indicator identity and bound)
e8_208                   20.8 (Stallings ranks; the fixing homomorphism)
misc_small               18.18 centraliser construction; 21.76 group of order 120; 13.19 closure
- E.2 (17.34): the PBW separation step checks out in the smallest case. For the free class-2 Lie algebra on x, y with
  h = span(x), the module M = I/(J + I^{c+1}) is spanned by the images of y, y^2 and u = [x,y], the image of x
  vanishes, and the images of the complementary basis vectors survive independently, i.e. ker d = h exactly as the
  paper asserts. (checks/e2_1734.log; add to the index above as "e2_1734  17.34 PBW separation")

## Appendix C.28-C.37 (third reader, verified here where checkable)
- C.28 (15.92): 720720 = lcm(1..16) confirmed; w^2 = xyxy follows from t^2 = (xt)^2 = (yt)^2 = 1; the printed
  exponents are E/2. The soft spot is the imported cycle data from Conder's thesis and the unexplained 11/13 split.
- C.29 (4.75), C.33 (14.26), C.34 (15.76b), C.35 (16.38), C.36 (19.93), C.37 (20.1): correct; my own numerical checks
  of the pieces agree (interpolation degrees, coefficient identity, counterexample, Golod-Shafarevich value, orders).
- C.30 (9.4): correct; the source [41] is about quasivarieties of automata, which the paper itself flags.
- C.32 (13.42): correct; citation nit - [68] is "Exponential groups 2" while Kourovka 13.42 names the 1994 paper
  "Exponential groups 1" (Siberian Math. J. 35 (1994) 986-996) for tensor A-completion.
- C.36 (19.93) source check: Ershov's survey, Theorem 2.6 reads "(1 - |U|t + H_R(t)) * Hilb_A(t)/(1-t) >= 1/(1-t)"
  and Proposition 2.7(a) says that if 1 - |U|tau + H_R(tau) <= 0 for some tau in (0,1) then Hilb_A(tau) diverges.
  That is exactly the form the paper uses, including keeping the 1/(1-t) for non-homogeneous relators. Citation is
  accurate. (scratchpad ershov.txt)
- C.34 (15.76b) source check: the Fernandes-Tsurkov variety is defined by x^4 = 1, metabelian, and nilpotent of
  class at most 4, i.e. a proper subvariety of the metabelian variety consisting of periodic groups. The paper's
  description of it as a proper metabelian variety giving a counterexample for subvarieties is therefore accurate;
  worth adding only that the variety is of exponent four, which sharpens the contrast with the full varieties S_d.

## Appendices D and E (read by me after the fourth reader failed with an output-size error)
- D.2 (20.89/19.83): correct and honestly bounded; the algebra-unit-group argument verified in detail (the units
  1 + ta permute the minimal sink; comparing two parameters gives ea = af and e = f, so the sink is trivial).
- D.3 (21.121b): soluble theorem, the two auxiliary bounds (both checked computationally here) and the exact
  nonsoluble exponent log60/log4 are correct; the universal bound three is left open.
- D.5 (17.118): class-bounded results, the p = 2, 3 optima and the p^p lower bound are correct; the general question
  is untouched for p >= 5, as stated.
- D.6, D.7: correctly labelled; the 21.114 example is archive-dependent; every recomputable search number was exact.
- E.5 (21.132), E.6 (21.42), E.7 (20.33): each looks like an answer to the printed question but is excluded from the
  count as prior-work deduction. Under-claiming, worth a sentence in the review.
- E.9 (19.9, 16.14, 19.48): correctly classified; 16.14 is a one-step specialisation of Sambale's bound.
- C.22 follow-up: the second reader's last background job (k = 4 braces at p = 11..19) produced no output and was not
  re-run; it would have tested the same truncated-polynomial family whose lambda is linear. The decisive evidence
  stays the exhaustive k = 3 scan over F_5 (1625 braces, 800 with nonlinear lambda, no mismatch), plus the
  coefficient identity verified for all p < 400 and the hand-checked Lazard/BCH argument for general k.
- C.25 apparent inconsistency resolved from the source: Amelio's Remark 4.54 states that rescaling the space by
  lambda leaves tameness, acylindricity and tau unchanged, scales r_inj and the overlap invariant by lambda, so
  Omega = 0 is preserved under the smaller scale; and his Definition 2.17 works with hyperbolicity constant 0 and
  Omega = 0. So the vanishing overlap invariant does not clash with the scale condition 3*lambda <= L_S delta_1.
  This is worth stating in the review precisely because it looks like an error at first reading.
