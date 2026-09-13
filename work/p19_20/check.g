# 19.20 (Cameron): |End(G)| = |PIso(G)| => G abelian?
Counts := function(G)
  local subs, types, t, H, nEnd, nPIso, N, q, id;
  subs := List(ConjugacyClassesSubgroups(G), c -> [Representative(c), Size(c)]);
  # PIso: sum over iso types T of (number of subgroups of type T)^2 * |Aut(T)|
  types := rec();
  for t in subs do
    id := String(IdGroup(t[1]));
    if not IsBound(types.(id)) then types.(id) := [0, Size(AutomorphismGroup(t[1]))]; fi;
    types.(id)[1] := types.(id)[1] + t[2];
  od;
  nPIso := Sum(RecNames(types), id -> types.(id)[1]^2 * types.(id)[2]);
  # End: sum over normal N of (number of subgroups H ~= G/N) * |Aut(G/N)|
  nEnd := 0;
  for N in NormalSubgroups(G) do
    q := G / N; id := String(IdGroup(q));
    if IsBound(types.(id)) then nEnd := nEnd + types.(id)[1] * types.(id)[2]; fi;
  od;
  return [nEnd, nPIso];
end;
for n in [2..200] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); c := Counts(G);
    if IsAbelian(G) and c[1] <> c[2] then Print("BUG? abelian ", [n,k], " ", c, "\n"); fi;
    if not IsAbelian(G) and c[1] = c[2] then Print("COUNTEREXAMPLE ", [n,k], " ", StructureDescription(G), " End=PIso=", c[1], "\n"); fi;
  od;
  if n mod 20 = 0 then Print("done order ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
