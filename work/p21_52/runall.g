Read("/project/work/p21_52/gorshkov.g");
it := SimpleGroupsIterator(60, 2000000);
for L in it do
  n := Size(L);
  # skip classes that are too big for now
  cls := Filtered(ConjugacyClasses(L), c -> Order(Representative(c)) = 2);
  if Maximum(List(cls, Size)) > 6000 then Print("SKIP (big class) ", Name(L), " ", List(cls,Size), "\n"); continue; fi;
  Analyse(L, Name(L));
od;
Print("FINISHED\n");
QUIT;
