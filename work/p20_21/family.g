# 20.21: targeted test of (L) for M = N x| V (N abelian 2-group, V ~= V4 <= Aut(N)) with an automorphism alpha of N of order 3
# normalising V and acting as a 3-cycle on V.  Then I = N works for the V4-part; we test for I' ~= N with M/I' ~= C4.
Read("/project/work/p20_21/test2021_fn.g");
TestFamily := function(N, name)
  local A, S3, alphas, alpha, C, cls, V, M, done, cnt;
  A := AutomorphismGroup(N);
  if Size(A) mod 3 <> 0 then Print(name, ": |Aut| not divisible by 3\n"); return; fi;
  S3 := SylowSubgroup(A, 3);
  alphas := Filtered(List(ConjugacyClasses(A), Representative), a -> Order(a) = 3);
  cnt := 0; done := [];
  for alpha in alphas do
    C := Centralizer(A, alpha);   # V must be normalised by alpha; V x| <alpha> ~= A4 inside A
    # Klein 4-subgroups V of A with alpha in N_A(V) acting as a 3-cycle: V <= [A, alpha]... enumerate V inside the subgroup <V, alpha> ~= A4:
    # find A4-subgroups of A containing alpha
    cls := Filtered(List(ConjugacyClassesSubgroups(A), Representative), S -> Size(S) = 12 and IdGroup(S) = [12,3]);
    for V in cls do
      # any conjugate of V containing an element of order 3 works; take derived subgroup of the A4
      M := SemidirectProduct(DerivedSubgroup(V), N);
      cnt := cnt + 1;
      if Test2021(M) then Print("  CANDIDATE from ", name, "\n"); fi;
    od;
    break;   # A4-subgroups enumerated once (independent of alpha)
  od;
  Print(name, ": tested ", cnt, " semidirect products M = N x| V4 of order ", Size(N)*4, "\n");
end;
for N in [AbelianGroup([8,8]), AbelianGroup([16,16]), AbelianGroup([4,4,4,4]), AbelianGroup([8,8,2,2]), AbelianGroup([4,4,2,2]), AbelianGroup([8,8,4,4]), AbelianGroup([32,32])] do
  TestFamily(N, StructureDescription(N));
od;
Print("FINISHED\n"); QUIT;
