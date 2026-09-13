Read("/project/work/p21_113/psi_check.g");
# 21.113(a) on perfect groups (library) and primitive groups of degree <= 40: diverse non-solvable groups
cnt := 0;
for n in [60..100000] do
  if NumberPerfectGroups(n) = 0 then continue; fi;
  for k in [1..NumberPerfectGroups(n)] do
    G := PerfectGroup(IsPermGroup, n, k);
    for p in PrimeDivisors(n) do
      bad := PsiCheck(G, p); cnt := cnt + 1;
      if Length(bad) > 0 then Print("COUNTEREXAMPLE? PerfectGroup(", n, ",", k, ") p=", p, " ", bad, "\n"); fi;
    od;
  od;
  Print("done perfect groups of order ", n, " total checks ", cnt, "\n");
od;
for d in [2..40] do
  for k in [1..NrPrimitiveGroups(d)] do
    G := PrimitiveGroup(d, k);
    if Size(G) > 2000000 then continue; fi;
    for p in PrimeDivisors(Size(G)) do
      bad := PsiCheck(G, p); cnt := cnt + 1;
      if Length(bad) > 0 then Print("COUNTEREXAMPLE? PrimitiveGroup(", d, ",", k, ") p=", p, " ", bad, "\n"); fi;
    od;
  od;
  Print("done primitive degree ", d, " total checks ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
