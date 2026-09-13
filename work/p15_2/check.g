# 15.2(a) (Isaacs): G solvable, x nonvanishing (chi(x)<>0 for all chi in Irr(G)) of even order => x in F(G)?
CheckOrder := function(n)
  local k, G, tbl, irr, cls, i, x, F, nv;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, k);
    if not IsSolvable(G) or IsNilpotent(G) then continue; fi;
    tbl := CharacterTable(G); irr := Irr(tbl); cls := ConjugacyClasses(tbl);
    F := FittingSubgroup(G);
    for i in [1..Length(cls)] do
      x := Representative(cls[i]);
      if Order(x) mod 2 <> 0 then continue; fi;
      if x in F then continue; fi;
      if ForAll(irr, chi -> chi[i] <> 0) then
        Print("COUNTEREXAMPLE ", [n,k], " ", StructureDescription(G), " nonvanishing element of order ", Order(x), " outside F(G)\n");
      fi;
    od;
  od;
  Print("done order ", n, "\n");
end;
for n in [2..1000] do if not IsPrimePowerInt(n) and n mod 2 = 0 and not n in [512, 768] then CheckOrder(n); fi; od;
Print("FINISHED\n"); QUIT;
