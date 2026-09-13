Read("/project/work/p19_56/check.g_fn");
for n in [60..100000] do
  if NumberPerfectGroups(n) = 0 then continue; fi;
  for k in [1..NumberPerfectGroups(n)] do
    G := PerfectGroup(IsPermGroup, n, k);
    v := Violates(G);
    if v = fail then Print("COUNTEREXAMPLE: PerfectGroup(", n, ",", k, ") ", StructureDescription(G), "\n");
    else Print("PerfectGroup(", n, ",", k, ") |Phi|=", Size(FrattiniSubgroup(G)), " violated by |a|=", Order(v[1]), " |b|=", Order(v[2]), " |ab|=", Order(v[1]*v[2]), "\n"); fi;
  od;
od;
Print("FINISHED\n"); QUIT;
