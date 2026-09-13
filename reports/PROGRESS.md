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
