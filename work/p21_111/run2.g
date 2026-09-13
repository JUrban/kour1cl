Read("/project/work/p21_111/tau.g");
for S in SimpleGroupsIterator(300001, 3000000) do
  Analyse(S, Name(S));
od;
Print("FINISHED\n"); QUIT;
