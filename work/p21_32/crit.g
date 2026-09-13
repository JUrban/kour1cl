# Necessary condition for G = H' (H finite): exists Q with Inn(G) <= Q <= Aut(G) and Q' = Inn(G).
# For Z(G)=1 this is also sufficient (H = Q).
HasQ := function(G)
  local A, I, cands, Q;
  A := AutomorphismGroup(G);
  I := InnerAutomorphismsAutomorphismGroup(A);
  # subgroups Q of A containing I with Q' = I  <=> Q/I abelian and Q' = I; enumerate via intermediate subgroups
  cands := IntermediateSubgroups(A, I).subgroups;
  Add(cands, A);
  Add(cands, I);
  return ForAny(cands, Q -> DerivedSubgroup(Q) = I);
end;
# Brute force: which groups of order <= n appear as derived subgroups of groups of order <= N
DerivedIds := function(N)
  local res, n, k, H, D, id;
  res := [];
  for n in [1..N] do
    if n in [512, 1024, 1536] then continue; fi;
    if NrSmallGroups(n) > 3000 then continue; fi;   # skip huge orders (256, 384, 768...)
    for k in [1..NrSmallGroups(n)] do
      H := SmallGroup(n, k);
      D := DerivedSubgroup(H);
      if Size(D) <= 32 then
        id := IdGroup(D);
        AddSet(res, id);
      fi;
    od;
  od;
  return res;
end;
