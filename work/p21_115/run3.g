Read("/project/work/p21_115/check.g");
for n in [49..72] do for k in [1..NrSmallGroups(n)] do
  G := SmallGroup(n,k); SearchGroup(G, 3);
od; Print("done order ", n, "\n"); od;
Print("FINISHED\n"); QUIT;
