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

## 2026-09-13 14:15 UTC
- **2.78/3.57 (Trofimov): main question SOLVED** — the sets of soluble and absolutely simple group-theoretic
  numbers are finite (every k ≥ 86 is realised by A5 × (M_{p^n} × C_{p^r})); also 0–6 and 8 are soluble, 7 is
  absolutely simple, f(S) ≥ 9 for simple S ≠ A5. Existence of composite non-soluble numbers left open.
  Report: reports/2.78_group_theoretic_numbers.md.
- 21.113: Robinson's own paper (arXiv:2505.03976) proves it only for PSL(2,q); deprioritised.
- Sweeps for 20.21, 19.20, 18.20, 18.119, 18.77, 17.128, 18.44, 14.44, 13.19 continue with no hits.
- 14:50 UTC: 2.78 construction verified numerically (f(A5 × M_343) = 30, p-group lemma for p=7, n≤4, r≤1).
  18.46 (Klyachko): minimal square-root overgroups computed: C2→4, C4→8, V4→16, S3→36, C6→12, C8→16, C4×C2→32;
  all ≤ |G|² so far (data collection continues).
- 15:00 UTC: **18.46 (Klyachko)**: computation shows the minimal H for G = D8 has order 128 = 2|G|² (SmallGroup(128,134),
  e.g. D8 ≀ C2), so the bound 2|G|² is sharp. Independent verification running (work/p18_46/verify_d8.g).
  20.30 verified for all centreless perfect groups of order < 10^6.
- 16:25 UTC: 18.46 verification complete (14 groups of order 128 work; none below). Report finalised.
  Started 17.1 (Isaacs partitions, exponent-3 groups of order 729, exact cover).
- 16:50 UTC: 17.1 (Isaacs): no partition of any exponent-3 group of order 3^6 into subgroups of order 27 with a
  non-abelian component (exact cover, all 7 groups). 2.78 lemma verified for p=7,11 (n ≤ 4, r ≤ 2).
  13.19: explicit class-2 construction of order 512 with Q/H ≅ D8 being verified in GAP.
- 17:30 UTC: **13.19 (Gorchakov) SOLVED (negative)**: explicit Q of order 512 (class 2), n = 3, Q/H ≅ D8;
  verified via pc presentation (work/p13_19/construct_pc2.g). Report: reports/13.19_subdirect_products_counterexample.md.
- 18:00 UTC: launched 18.56 (core-2 2-groups ≤ 256), 18.120 (factorised p-groups), 21.2 (order-divisibility bijections),
  19.12 (conjugacy-expansive simple groups with ≤ 24 classes, C checker), 15.3, 20.4, 19.33, 17.1 (p=5).
  Stopped low-value sweeps (18.20, 18.119, 14.44, 19.20, 11.18 PSL(2,q) quotients).
- 18:45 UTC: 18.117 verified for M11, M12, M22, M23, M24, J1, J2, HS, J3, McL, He, Co3, Co2, Suz (all classes are
  coprime commutators; explicit certificates found). Fi22, ON, Ru, ... running. 19.12 verified for the 34 simple
  groups with ≤ 24 classes; 20.100 (n=4) verified for all groups of order coprime to 30 up to 300.
  20.71 (graph cards, k=2,3): exhaustive nauty search over connected graphs with ≤ 9 vertices: no example; n=10,11 running.
- 19:30 UTC: **13.19 strengthened**: uniform construction — every finite p-group P is Q/H for a configuration with
  n = class(P)+1 (Möbius lemma for word maps on nilpotent groups); verified for P = C3 ≀ C3 (|Q| = 3^32). So 13.19
  fails for every prime p. 21.2 verified for the six smallest simple groups; 20.71(a,b) none up to 10 vertices.
