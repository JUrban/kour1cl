Read("/project/work/p21_111/tau2.g");
for S in SimpleGroupsIterator(3000001, 10000000) do
  Analyse2(S, Name(S));
od;
Print("FINISHED\n"); QUIT;
