# 20.86 (Schmid): s_p(G) = 1 + kp > 1 Sylow p-subgroups; |G_p| = |P| f_p(G), f_p = 1 + l(p-1). Is l >= k^((p-1)/p) always?
# Equivalently (Gheri's inequality) f_p^p >= s_p^(p-1). Test l^p >= k^(p-1).
Check := function(G, name)
  local p, P, s, k, np, f, l, bad;
  bad := false;
  for p in PrimeDivisors(Size(G)) do
    P := SylowSubgroup(G, p);
    s := Index(G, Normalizer(G, P));
    if s = 1 then continue; fi;
    k := (s - 1) / p;
    np := Number(G, g -> IsOne(g) or (IsPrimePowerInt(Order(g)) and Order(g) mod p = 0));
    f := np / Size(P);
    l := (f - 1) / (p - 1);
    if not IsInt(l) then Print("NONINTEGER l?? ", name, " p=", p, "\n"); fi;
    if l^p < k^(p-1) then Print("COUNTEREXAMPLE ", name, " p=", p, " s_p=", s, " k=", k, " f_p=", f, " l=", l, "\n"); bad := true; fi;
  od;
  return bad;
end;
cnt := 0;
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for i in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, i); if IsSolvable(G) then continue; fi;
    cnt := cnt + 1; Check(G, [n,i]);
  od;
od;
Print("small groups done: ", cnt, " nonsolvable groups\n");
for G in SimpleGroupsIterator(60, 3000000) do Check(G, Name(G)); od;
Print("simple groups done\n");
for n in [60..200000] do if NumberPerfectGroups(n) > 0 then for i in [1..NumberPerfectGroups(n)] do
  G := PerfectGroup(IsPermGroup, n, i); Check(G, ["perfect", n, i]); od; fi; od;
Print("FINISHED\n"); QUIT;
