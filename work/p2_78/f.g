# 2.78 (Trofimov): f(G) = number of orders d such that G has a non-normal subgroup of order d
fval := function(G)
  local ccs; ccs := ConjugacyClassesSubgroups(G);
  return Length(Set(List(Filtered(ccs, c -> Size(c) > 1), c -> Size(Representative(c)))));
end;
res := rec();   # k -> list of [order, id, simple?]
for n in [60..1000] do
  if NrSmallGroups(n) > 3000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    if IsSolvable(G) then continue; fi;
    f := fval(G);
    if not IsBound(res.(f)) then res.(f) := []; fi;
    Add(res.(f), [n, k, IsSimple(G), StructureDescription(G)]);
  od;
  Print("done order ", n, "\n");
od;
for f in Set(List(RecNames(res), Int)) do
  Print("f=", f, ": ", Length(res.(String(f))), " groups; examples ", res.(String(f)){[1..Minimum(4, Length(res.(String(f))))]}, "\n");
od;
Print("FINISHED\n"); QUIT;
