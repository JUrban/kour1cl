# 21.135 / 21.59(a): groups H with the same multiset of irreducible character degrees as G, G almost simple / trivial solvable radical
Degs := G -> SortedList(List(Irr(CharacterTable(G)), x -> x[1]));
CheckOrder := function(n)
  local k, G, d, tab, ids, targets, G0, others, id;
  tab := [];
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    if IsTrivial(RadicalGroup(G)) then
      d := Degs(G);
      others := [];
      for id in [1..NrSmallGroups(n)] do
        if id = k then continue; fi;
        G0 := SmallGroup(n, id);
        if Degs(G0) = d then Add(others, [id, StructureDescription(G0), IsTrivial(RadicalGroup(G0))]); fi;
      od;
      Print("order ", n, " id ", k, " ", StructureDescription(G), " degrees ", d, " -> same-degree groups: ", others, "\n");
    fi;
  od;
end;
for n in [60, 120, 168, 336, 360, 504, 660, 720, 1092, 1320, 1440, 1512] do CheckOrder(n); od;
Print("FINISHED\n"); QUIT;
