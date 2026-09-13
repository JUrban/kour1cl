# 20.115 (Wilde): chi(x) <> 0  =>  o(x) | |G|/chi(1) ?  Check nonsoluble small groups and library tables.
CheckTable := function(tbl, name)
  local irr, ords, cls, chi, i, n, bad;
  irr := Irr(tbl); ords := OrdersClassRepresentatives(tbl); n := Size(tbl); bad := false;
  for chi in irr do
    for i in [1..Length(ords)] do
      if chi[i] <> 0 and (n / chi[1]) mod ords[i] <> 0 then
        Print("COUNTEREXAMPLE ", name, " chi(1)=", chi[1], " o(x)=", ords[i], " |G|=", n, " chi(x)=", chi[i], "\n"); bad := true;
      fi;
    od;
  od;
  return bad;
end;
cnt := 0;
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsSolvableGroup(G) then continue; fi;
    cnt := cnt + 1; CheckTable(CharacterTable(G), Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
  od;
  if n mod 100 = 0 then Print("done order ", n, " nonsoluble groups so far ", cnt, "\n"); fi;
od;
Print("small groups done: ", cnt, " nonsoluble groups\n");
cnt := 0;
for nm in AllCharacterTableNames(IsDuplicateTable, false) do
  tbl := CharacterTable(nm);
  if NrConjugacyClasses(tbl) > 300 then continue; fi;
  cnt := cnt + 1; CheckTable(tbl, nm);
od;
Print("library tables done: ", cnt, "\nFINISHED\n"); QUIT;
