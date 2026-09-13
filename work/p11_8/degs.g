# 11.8(b) (Berkovich): same multiset of irreducible character degrees, G soluble => H soluble?
Degs := G -> SortedList(List(Irr(CharacterTable(G)), x -> x[1]));
for n in [60..1200] do
  if NrSmallGroups(n) > 20000 then continue; fi;
  if n mod 60 <> 0 and n mod 168 <> 0 and n mod 360 <> 0 and n mod 504 <> 0 and n mod 660 <> 0 and n mod 1092 <> 0 then continue; fi;
  ids := [1..NrSmallGroups(n)];
  nonsol := Filtered(ids, k -> not IsSolvable(SmallGroup(n,k)));
  if Length(nonsol) = 0 then continue; fi;
  degN := List(nonsol, k -> Degs(SmallGroup(n,k)));
  cnt := 0;
  for k in ids do
    G := SmallGroup(n,k);
    if not IsSolvable(G) then continue; fi;
    d := Degs(G);
    pos := Position(degN, d);
    if pos <> fail then
      Print("COUNTEREXAMPLE order ", n, ": soluble id ", k, " ", StructureDescription(G), " and nonsoluble id ", nonsol[pos], " ", StructureDescription(SmallGroup(n, nonsol[pos])), " degrees ", d, "\n");
      cnt := cnt + 1;
    fi;
  od;
  Print("done order ", n, " (", Length(nonsol), " nonsoluble groups) hits ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
