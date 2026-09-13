# 20.55 (Mattarei): soluble G, H with identical character tables and derived lengths 2 and 4?
for n in [48..1000] do
  if NrSmallGroups(n) > 3000 then continue; fi;
  dl4 := []; dl2 := [];
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if not IsSolvable(G) then continue; fi;
    d := DerivedLength(G);
    if d = 4 then Add(dl4, k); elif d = 2 then Add(dl2, k); fi;
  od;
  if Length(dl4) = 0 or Length(dl2) = 0 then continue; fi;
  # cheap invariants: class sizes multiset and degrees multiset
  inv := function(k) local G, t; G := SmallGroup(n,k); t := CharacterTable(G);
    return [SortedList(SizesConjugacyClasses(t)), SortedList(List(Irr(t), x->x[1])), SortedList(OrdersClassRepresentatives(t))]; end;
  inv4 := List(dl4, inv);
  for k in dl2 do
    i2 := inv(k);
    for j in [1..Length(dl4)] do
      if inv4[j] = i2 then
        t2 := CharacterTable(SmallGroup(n,k)); t4 := CharacterTable(SmallGroup(n,dl4[j]));
        if TransformingPermutationsCharacterTables(t2, t4) <> fail then
          Print("FOUND identical tables: order ", n, " ids ", k, " (dl 2) and ", dl4[j], " (dl 4)\n");
        fi;
      fi;
    od;
  od;
  Print("done order ", n, " (", Length(dl2), " dl2, ", Length(dl4), " dl4)\n");
od;
Print("FINISHED\n"); QUIT;
