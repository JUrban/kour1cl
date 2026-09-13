# 16.60 (MacHale): T(G) = sum of irreducible character degrees; S_alpha = {g : alpha(g) = g^-1}. Is T(G) >= |S_alpha| ?
# Numerical sanity check of the theorem (proved in reports/16.60_twisted_FS.md) on small groups.
CheckGroup := function(G)
  local T, A, cls, a, s, maxS, best;
  T := Sum(Irr(CharacterTable(G)), x -> x[1]);
  A := AutomorphismGroup(G);
  maxS := 0; best := fail;
  for cls in ConjugacyClasses(A) do
    a := Representative(cls);
    s := Number(G, g -> Image(a, g) = g^-1);
    if s > maxS then maxS := s; best := Order(a); fi;
  od;
  return [T, maxS, best];
end;
for n in [2..200] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); r := CheckGroup(G);
    if r[2] > r[1] then Print("COUNTEREXAMPLE ", [n,k], " T=", r[1], " |S|=", r[2], "\n"); fi;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
