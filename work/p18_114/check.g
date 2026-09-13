# 18.114 (Schmid): irreducible 5'-subgroup G of GL(n,5) with k(VG) = |V| = 5^n and G not cyclic?
LoadPackage("irredsol");
for n in [1,2,3] do
  cnt := 0;
  for G in AllIrreducibleSolvableMatrixGroups(Degree, n, Field, GF(5)) do
    if Size(G) mod 5 = 0 then continue; fi;
    V := GF(5)^n;
    S := SemidirectProduct(G, V);
    k := NrConjugacyClasses(S);
    cnt := cnt + 1;
    if k = 5^n then Print("k(VG)=|V| for G of order ", Size(G), " cyclic=", IsCyclic(G), " n=", n, " ", StructureDescription(G), "\n"); fi;
  od;
  Print("done n=", n, " groups tested ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
