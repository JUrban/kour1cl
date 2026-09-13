SemiProp := function(phi, psi) local ratios, i, r; ratios := [];
  for i in [1..Length(phi)] do
    if psi[i] = 0 and phi[i] = 0 then continue; fi;
    if psi[i] = 0 then r := infinity; else r := phi[i] / psi[i]; fi;
    AddSet(ratios, r);
  od; return Length(ratios) = 2; end;
cnt := 0;
for nm in AllCharacterTableNames(IsDuplicateTable, false, Size, [1..10^12]) do
  tbl := CharacterTable(nm); irr := Irr(tbl); n := Length(irr);
  if n > 200 then continue; fi;
  cnt := cnt + 1;
  for i in [1..n] do for j in [i+1..n] do
    if irr[i][1] <> irr[j][1] and SemiProp(irr[i], irr[j]) then
      Print("COUNTEREXAMPLE ", nm, " degrees ", irr[i][1], " ", irr[j][1], "\n");
    fi;
  od; od;
od;
Print("checked ", cnt, " library tables\nFINISHED\n"); QUIT;
