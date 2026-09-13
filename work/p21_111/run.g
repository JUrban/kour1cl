Read("/project/work/p21_111/tau.g");
for S in SimpleGroupsIterator(60, 300000) do
  Analyse(S, Name(S));
od;
Print("FINISHED\n"); QUIT;
