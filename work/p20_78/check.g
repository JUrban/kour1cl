# 20.78 (Qian's codegree conjecture): element of order m  =>  m divides some cod(chi) = |G:ker chi|/chi(1).
CodCheck := function(tbl, name)
  local irr, ords, sizes, cods, chi, ker, i, m, bad;
  irr := Irr(tbl); ords := OrdersClassRepresentatives(tbl); sizes := SizesConjugacyClasses(tbl); bad := false;
  cods := [];
  for chi in irr do
    ker := Sum(Filtered([1..Length(ords)], i -> chi[i] = chi[1]), i -> sizes[i]);   # |ker chi|
    AddSet(cods, (Size(tbl) / ker) / chi[1]);
  od;
  for m in Set(ords) do
    if not ForAny(cods, c -> c mod m = 0) then Print("COUNTEREXAMPLE ", name, " m=", m, " Cod=", cods, "\n"); bad := true; fi;
  od;
  return bad;
end;
cnt := 0;
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsSolvableGroup(G) then continue; fi;
    if Size(FittingSubgroup(G)) = 1 then continue; fi;   # known for F(G) = 1
    cnt := cnt + 1; CodCheck(CharacterTable(G), Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
  od;
  if n mod 100 = 0 then Print("done order ", n, " groups so far ", cnt, "\n"); fi;
od;
Print("small groups done: ", cnt, "\n");
cnt := 0;
for nm in AllCharacterTableNames(IsDuplicateTable, false) do
  tbl := CharacterTable(nm);
  if NrConjugacyClasses(tbl) > 300 then continue; fi;
  cnt := cnt + 1; CodCheck(tbl, nm);
od;
Print("library tables done: ", cnt, "\n");
for n in [60..10^6] do
  if NumberPerfectGroups(n) = 0 then continue; fi;
  for k in [1..NumberPerfectGroups(n)] do
    G := PerfectGroup(IsPermGroup, n, k);
    if Size(FittingSubgroup(G)) = 1 then continue; fi;
    CodCheck(CharacterTable(G), Concatenation("PerfectGroup(", String(n), ",", String(k), ")"));
  od;
od;
Print("perfect groups done\nFINISHED\n"); QUIT;
