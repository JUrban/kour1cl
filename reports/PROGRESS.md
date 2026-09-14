# Progress log

## 2026-09-13 08:05 UTC — start
- Environment: 112 cores / 251 GB (self-limit 20 cores / 100 GB), GAP 4.16.1 (+174 pkgs), python3.12, gcc, internet.
- Notebook text: docs/21tkt.txt (15364 lines); open problems occupy lines ~140–9066; 21st-issue new problems start at p.167.
- Plan: triage the whole notebook for problems attackable by computation + short rigorous argument in <48h.

## 2026-09-13 09:10 UTC — status after ~1 h
- Triage of issues 1–20 delegated to 5 agents (one hit the output limit; re-requested compact reports).
- 21st issue read by me; candidate table in plans/PLAN.md.
- **21.32 (Cameron, decidability of "G ≅ H′"): SOLVED (draft report reports/21.32_derived_subgroup_decidability.md).**
  Theorem: if G ≅ H′ then G ≅ (H*)′ with |H*| ≤ |Aut G|·|Z(G)|²·(2 exp Z(G))^{2⌈log₂|G|⌉}; necessary condition
  ∃ Inn(G) ≤ Q ≤ Aut(G) with Q′ = Inn(G) (sufficient when Z(G)=1). Brute-force cross-check consistent (work/p21_32).
- 21.115 (Sambale): already solved in arXiv:2609.09052 (Sept 2026) — dropped.
- Searches with no counterexample so far: 21.29 (all primitive groups deg ≤ 4095), 21.99 (all transitive groups deg ≤ 47
  except 32), 21.113(a) (all groups of order ≤ 256 and more; (b) for 1663 library tables and p-solvable groups ≤ 300),
  21.26 (orders ≤ ~500), 21.52/21.53 (simple groups up to M11), 21.25 (simple groups so far), 21.27/21.28.
- 21.111: τ-groups found so far: A6, PSL(2,27), PSL(2,81) (τ-involutions); pattern PSL(2,3^n). No odd-order τ yet.

## 2026-09-13 13:05 UTC
- Triage from issues 10–18 received (compact). Many sweeps launched; none found a counterexample so far
  (summary table: reports/verifications.md).
- **16.60 (MacHale) SOLVED** (reports/16.60_twisted_frobenius_schur.md): T(G) ≥ |S_α| for all automorphisms.
- 21.111: τ-groups among simple groups of order ≤ 10^7 are exactly PSL(2,3^n), n=2..5; all τ-automorphisms are
  involutions (data for (a); nothing for (b) yet).
- 11.18: G(2,3) resists (perfect, no small quotients, coset enumeration overflow at 4e8) — likely infinite but unproved.

## 2026-09-13 13:27 UTC (clock corrected from git; earlier drafts overstated the time)
- **2.78/3.57 (Trofimov): main question SOLVED** — the sets of soluble and absolutely simple group-theoretic
  numbers are finite (every k ≥ 86 is realised by A5 × (M_{p^n} × C_{p^r})); also 0–6 and 8 are soluble, 7 is
  absolutely simple, f(S) ≥ 9 for simple S ≠ A5. Existence of composite non-soluble numbers left open.
  Report: reports/2.78_group_theoretic_numbers.md.
- 21.113: Robinson's own paper (arXiv:2505.03976) proves it only for PSL(2,q); deprioritised.
- Sweeps for 20.21, 19.20, 18.20, 18.119, 18.77, 17.128, 18.44, 14.44, 13.19 continue with no hits.
- 13:44 UTC: 2.78 construction verified numerically (f(A5 × M_343) = 30, p-group lemma for p=7, n≤4, r≤1).
  18.46 (Klyachko): minimal square-root overgroups computed: C2→4, C4→8, V4→16, S3→36, C6→12, C8→16, C4×C2→32;
  all ≤ |G|² so far (data collection continues).
- 13:52 UTC: **18.46 (Klyachko)**: computation shows the minimal H for G = D8 has order 128 = 2|G|² (SmallGroup(128,134),
  e.g. D8 ≀ C2), so the bound 2|G|² is sharp. Independent verification running (work/p18_46/verify_d8.g).
  20.30 verified for all centreless perfect groups of order < 10^6.
- 14:09 UTC: 18.46 verification complete (14 groups of order 128 work; none below). Report finalised.
  Started 17.1 (Isaacs partitions, exponent-3 groups of order 729, exact cover).
- 14:15 UTC: 17.1 (Isaacs): no partition of any exponent-3 group of order 3^6 into subgroups of order 27 with a
  non-abelian component (exact cover, all 7 groups). 2.78 lemma verified for p=7,11 (n ≤ 4, r ≤ 2).
  13.19: explicit class-2 construction of order 512 with Q/H ≅ D8 being verified in GAP.
- 14:21 UTC: **13.19 (Gorchakov) SOLVED (negative)**: explicit Q of order 512 (class 2), n = 3, Q/H ≅ D8;
  verified via pc presentation (work/p13_19/construct_pc2.g). Report: reports/13.19_subdirect_products_counterexample.md.
- 14:24 UTC: launched 18.56 (core-2 2-groups ≤ 256), 18.120 (factorised p-groups), 21.2 (order-divisibility bijections),
  19.12 (conjugacy-expansive simple groups with ≤ 24 classes, C checker), 15.3, 20.4, 19.33, 17.1 (p=5).
  Stopped low-value sweeps (18.20, 18.119, 14.44, 19.20, 11.18 PSL(2,q) quotients).
- 14:34 UTC: 18.117 verified for M11, M12, M22, M23, M24, J1, J2, HS, J3, McL, He, Co3, Co2, Suz (all classes are
  coprime commutators; explicit certificates found). Fi22, ON, Ru, ... running. 19.12 verified for the 34 simple
  groups with ≤ 24 classes; 20.100 (n=4) verified for all groups of order coprime to 30 up to 300.
  20.71 (graph cards, k=2,3): exhaustive nauty search over connected graphs with ≤ 9 vertices: no example; n=10,11 running.
- 14:38 UTC: **13.19 strengthened**: uniform construction — every finite p-group P is Q/H for a configuration with
  n = class(P)+1 (Möbius lemma for word maps on nilpotent groups); verified for P = C3 ≀ C3 (|Q| = 3^32). So 13.19
  fails for every prime p. 21.2 verified for the six smallest simple groups; 20.71(a,b) none up to 10 vertices.

## 2026-09-13 15:35 UTC
- Clock note: all times from here on are taken from `date -u` (earlier entries were corrected from git).
- 21.26 (Lisi–Sabatini): new double-coset checker (`work/p21_26/check2.g`); verified for all groups of order ≤ 2000
  except 1024/1280/1536/1792 (768, 1152, 1920 partly still running) and for ~60 larger groups (S₈–S₁₀, M₁₁, M₁₂, M₂₂,
  L₃(q), U₃(q), Sz(8), wreath products, AGL, PΓL, Sp(4,3), …). Observation: every inclusion-minimal P ∩ P^x equals
  O_p(G) (consistent with Zenkov's theorem), and a common x is found by ≤ 10 random samples in every case.
- 16.14 (Berkovich): Theorem B (structure of a minimal counterexample: d = 2r+1, E ≤ Φ, all maximal subgroups
  extremal with the same Frattini subgroup, order-doubling on G → G/E, Chevalley–Warning bound on the 2-rank of G/E,
  subgroups of G/E with trivial multiplier are abelian). Cohomological search over the possible quotients H = G/E
  (GAP `TwoCocycles` + `Extension`): no counterexample of order ≤ 2¹⁰; none of order 2¹¹ with r = 3; order 2¹²
  (r = 3, 1139 candidate H of order 512) running. Report: reports/16.14_notes.md.
- 20.71: n = 11 exhaustive (1 006 700 565 connected graphs): no example with k ∈ {2,3} card types and > k orbits.
- 18.119 targeted sweep (δ₂, γ₃; orders ≤ 2000, derived length ≥ 3): no counterexample. 18.120: none for
  p-groups of order ≤ 64, 3⁵, 5³. 18.20: all 2063 library tables (≤ 200 classes) — semiproportional irreducibles
  have equal degrees.
- Stopped low-value sweeps: 17.128, 18.44, 16.33, 16.63, 21.113 (orders 769–1000 reached 959), 2.78 L₂(q) data.

## 2026-09-13 16:15 UTC
- 16.14: order 2¹² (r = 3) excluded (1139 candidate quotients H of order 512 all fail); unconditional up to 2¹⁰.
- 20.21: local condition corrected (3-power-order automorphisms), search to 252 clean, 256 running; rigorous proof
  that abelian K cannot occur.
- New sweeps (issues 19–20, re-triaged): 20.115 (Wilde, o(x) | |G|/χ(1)): no counterexample among non-soluble
  groups ≤ 2000 and 2275 library tables; 20.78 (codegree conjecture): none (same range + perfect groups running);
  19.108 (p-groups, o(x) | |P|/χ(1)²): none up to 3⁷, 5⁵, 7⁴; 20.49 (2-generated subgroup of the same exponent):
  running; 20.122 (Zenkov, three nilpotent subgroups): sweep over all nilpotent subgroups running (Sylow-only
  version is trivial by Zenkov's theorem).
- **20.37 (Hooshmand, G = AB with |A| = a, |B| = b)**: computed the "chain-achievable" factor sizes for all simple
  groups of order ≤ 10⁶; PSL(2,8) is the first group where the subgroup-chain method fails (12·42, 21·24).
  Proved Theorem 1: if H ≤ K ≤ G, |K:H| even and K = ⟨H,x⟩, then 2|H| ∈ L(G) (perfect matching in a connected
  vertex-transitive graph, Gallai–Edmonds). Introduced a two-sided construction A = HX, B = YK (H, K with regular
  double cosets) reducing the search to tiny exact-cover problems; with it every factor size left open by
  Theorem 1 has been realised so far (PSL(2,8), PSL(2,13), PSL(2,17), PSL(2,19), PSL(2,23), PSL(2,25),
  PSL(2,27), PSL(3,4), …); all found A, B are re-verified in GAP. Report: reports/20.37_subset_factorizations.md.

## 2026-09-14 02:10 UTC
- 16.14: the order-2¹¹ case is now closed unconditionally: all 7 111 878 groups H of order 512 with d(H) = 5 fail the
  2-covering-group test (F3′: some involution of H lifts to an involution of P*(H)) or the Frattini test (F2).
  Theorem C: no counterexample of order ≤ 2¹¹; none of order 2¹² with rank Z(G) ≥ 3.
- 20.21: local condition (L) excluded for all |K| ≤ 256 and for rank-3 groups of order 512; rank 4 running.
- 20.37: 253 of the 400 non-chain-achievable factor sizes (simple groups ≤ 10⁶) realised and GAP-verified; queues
  still running for the rest.
- 19.56: theorem for minimal simple groups; all perfect groups ≤ 10⁵ violate the hypothesis.

## 2026-09-14 12:30 UTC
- 20.21: the local condition (L) is now excluded for |K| ≤ 256, |K| = 512 of rank ≤ 4 (all 420 514 such groups),
  and all orders 260–1000 divisible by 4 except 512 (rank ≥ 5) and 768; rank ≥ 5 at 512 is out of reach
  (≈ 2 s per group). No candidate anywhere.
- 20.37: 261/400 sizes realised (280 GAP-verified factorisations); searches for the hard leftovers continue.
- 21.113: orders 960–1000 finished (sweep complete to 1000). 20.78 and 18.56 long runs stopped (partial ranges recorded).
- Review pass over all reports (21.32, 16.60, 2.78, 18.46, 13.19, 16.14, 20.21, 21.111, 18.117): small text fixes only.
