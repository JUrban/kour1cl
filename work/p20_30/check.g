# 20.30 (Neumann, Vaughan-Lee): G perfect, centreless, n = max class size; is |G| <= n^2 ?
for n in [60..1000000] do
  if NumberPerfectGroups(n) = 0 then continue; fi;
  for i in [1..NumberPerfectGroups(n)] do
    G := PerfectGroup(IsPermGroup, n, i);
    if Size(Center(G)) > 1 then continue; fi;
    m := Maximum(List(ConjugacyClasses(G), Size));
    if Size(G) > m^2 then Print("COUNTEREXAMPLE PerfectGroup(", n, ",", i, ") |G|=", n, " max class ", m, "\n"); fi;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
