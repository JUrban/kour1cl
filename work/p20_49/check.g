# 20.49 (Lucchini): every finite group has a 2-generated subgroup of the same exponent?
Has2Gen := function(G)
  local e, cls, x, y, reps;
  e := Exponent(G);
  reps := List(ConjugacyClasses(G), Representative);
  for x in reps do
    if Exponent(Subgroup(G, [x])) = e then return true; fi;
    for y in Elements(G) do
      if Exponent(Subgroup(G, [x, y])) = e then return true; fi;
    od;
  od;
  return false;
end;
cnt := 0;
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsSolvableGroup(G) then continue; fi;
    cnt := cnt + 1;
    if not Has2Gen(G) then Print("COUNTEREXAMPLE SmallGroup(", n, ",", k, ") ", StructureDescription(G), " exponent ", Exponent(G), "\n"); fi;
  od;
  if n mod 100 = 0 then Print("done order ", n, " nonsoluble groups so far ", cnt, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
