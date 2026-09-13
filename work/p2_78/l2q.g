# f(PSL(2,q)) = |Ord| - 2 for prime powers q up to 400, plus other small simple groups
for q in Filtered([4..400], IsPrimePowerInt) do
  S := PSL(2,q);
  ords := Set(List(ConjugacyClassesSubgroups(S), c -> Size(Representative(c))));
  Print("L2(", q, ") f=", Length(ords)-2, "\n");
od;
for S in SimpleGroupsIterator(20000, 3000000) do
  if Size(S) > 500000 then continue; fi;
  ords := Set(List(ConjugacyClassesSubgroups(S), c -> Size(Representative(c))));
  Print(Name(S), " f=", Length(ords)-2, "\n");
od;
Print("FINISHED\n"); QUIT;
