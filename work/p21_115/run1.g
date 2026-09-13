Read("/project/work/p21_115/check.g");
for n in [2..48] do for k in [1..NrSmallGroups(n)] do
  G := SmallGroup(n,k); SearchGroup(G, 4);
od; Print("done order ", n, "\n"); od;
Print("FINISHED\n"); QUIT;
