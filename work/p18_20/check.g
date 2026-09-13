# 18.20 (Belonogov): semiproportional irreducible characters have equal degrees?
SemiProp := function(phi, psi)
  local ratios, i, r;
  ratios := [];
  for i in [1..Length(phi)] do
    if psi[i] = 0 and phi[i] = 0 then continue; fi;
    if psi[i] = 0 then r := infinity; else r := phi[i] / psi[i]; fi;
    AddSet(ratios, r);
  od;
  return Length(ratios) = 2;
end;
CheckTable := function(tbl, name)
  local irr, i, j;
  irr := Irr(tbl);
  for i in [1..Length(irr)] do for j in [i+1..Length(irr)] do
    if irr[i][1] <> irr[j][1] and SemiProp(irr[i], irr[j]) then
      Print("COUNTEREXAMPLE ", name, " degrees ", irr[i][1], " ", irr[j][1], "\n");
    fi;
  od; od;
end;
for n in [2..300] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    CheckTable(CharacterTable(G), [n,k]);
  od;
  if n mod 25 = 0 then Print("done order ", n, "\n"); fi;
od;
for nm in AllCharacterTableNames(IsDuplicateTable, false, Size, [1..10^8]) do
  CheckTable(CharacterTable(nm), nm);
od;
Print("FINISHED\n"); QUIT;
