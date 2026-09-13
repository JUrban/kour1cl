Read("/project/work/p20_122/fn2.g");
for n in [181..200] do
  if Length(PrimeDivisors(n)) < 2 then continue; fi;
  tot := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsNilpotent(G) then continue; fi;
    tot := tot + CheckGroup2(G, Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
  od;
  Print("done order ", n, " triples checked ", tot, "\n");
od;
Print("FINISHED 181..200\n"); QUIT;
