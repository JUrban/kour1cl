# Results index (Kourovka Notebook, 21st ed.) — final status 2026-09-15 09:45 UTC

## Solved (complete answers with proofs / verified computations)
| Problem | Answer | Report |
|---|---|---|
| 21.32 (Cameron) | Decidable; witness H* of quasi-polynomial size; necessary condition Q′ = Inn(G) (sufficient if Z(G)=1) | `21.32_derived_subgroup_decidability.md` |
| 16.60 (MacHale) | Yes: T(G) ≥ |S_α| for every α ∈ Aut G | `16.60_twisted_frobenius_schur.md` |
| 2.78/3.57 (Trofimov) | Soluble and absolutely simple numbers form finite sets (all k ≥ 86 are realised); 0–6, 8 soluble; 7 absolutely simple | `2.78_group_theoretic_numbers.md` |
| 18.46 (Klyachko) | Yes, |H| ≤ 2|G|² is sharp (G = D₈ needs |H| = 128) | `18.46_square_roots_sharpness.md` |
| 13.19 (Gorchakov) | No, for every prime p: every finite p-group P occurs as Q/H (uniform construction + proof); explicit example of order 2⁹ with Q/H ≅ D₈ | `13.19_subdirect_products_counterexample.md` |

## Partial results
| Problem | Result | Report |
|---|---|---|
| 16.14 (Berkovich) | true for class-2 groups with G² ≤ Z(G) (Chevalley–Warning); a minimal counterexample has d = 2r+1 and rigid structure (Theorem B); no counterexample of order ≤ 2¹¹ (7.1 million candidate quotients of order 512 excluded via the 2-covering group), none of order 2¹² with rank Z(G) ≥ 3 | `16.14_notes.md` |
| 20.21 (Verret–Conder) | structural restrictions; no example of order ≤ 2000; the local condition (L) (which any example must satisfy) fails for all |K| ≤ 256, for |K| = 512 of rank ≤ 4 and for all |K| ≤ 1000 divisible by 4 except 512 (rank ≥ 5) and 768; Lemma T2: (L) is impossible unless K = I·φ(I); abelian K impossible | `20.21_notes.md` |
| 20.37 (Hooshmand) | chain-achievable factor sizes for all simple groups ≤ 10⁶ (PSL(2,8) is the first where subgroup chains fail); Theorem 1 (2|H| ∈ L(G) via perfect matchings in vertex-transitive graphs); two-sided coset construction realising most of the remaining sizes computationally (267 of 400, 286 factorisations verified in GAP; PSL(3,4) 70·288 and Sz(8) 70·416 are the smallest open cases) | `20.37_subset_factorizations.md` |
| 21.26 (Lisi–Sabatini) | yes for groups with two prime divisors (G = PQ); verified for all groups of order ≤ 2000 (a few 2-heavy orders excepted) and many larger groups | `21.26_notes.md`, `verifications.md` |
| 18.117 (Shumyatsky) | verified for 15 sporadic groups (M11 … Fi22) | `18.117_coprime_commutators_sporadic.md` |
| 21.111 (Revin–Yang) | τ-groups of order ≤ 10⁷ are exactly PSL(2,3ⁿ), n = 2..5; proof that PSL(2,3ⁿ) are τ-groups | `21.111_tau_groups_partial.md` |
| 19.56 (Monakhov) | every minimal simple group violates the hypothesis (uniform proof: involution and odd-prime-order ⋆-commutators in a dihedral configuration); a counterexample must be a minimal non-soluble group with non-trivial Frattini subgroup; verified for all non-soluble groups ≤ 2000 and all perfect groups ≤ 10⁵ | `19.56_star_commutators.md` |
| many | exhaustive verifications in bounded ranges (no counterexamples) | `verifications.md` |

Work directories: `work/p<problem>/` (scripts + logs). Progress log: `PROGRESS.md`.
