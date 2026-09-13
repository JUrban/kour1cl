# f(S) = |Ord(S)| - 2 for simple S
for S in SimpleGroupsIterator(60, 20000) do
  ords := Set(List(ConjugacyClassesSubgroups(S), c -> Size(Representative(c))));
  Print(Name(S), " |S|=", Size(S), " f=", Length(ords)-2, " Ord=", ords, "\n");
od;
Print("FINISHED\n"); QUIT;
