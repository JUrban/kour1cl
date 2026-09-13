# 20.99 (Sun): k pairwise disjoint left cosets a_i G_i (k > 1) => gcd([G:G_i],[G:G_j]) >= k for some i<j.  Known k <= 4.
# Search2099 for 5 pairwise disjoint cosets with all pairwise gcd of indices <= 4.
Search2099 := function(G)
  local subs, idx, cosets, n, i, j, combos, rec5, found, cands;
  n := Size(G);
  subs := Filtered(Concatenation(List(ConjugacyClassesSubgroups(G), c -> AsList(c))), S -> Index(G,S) >= 2);
  idx := List(subs, S -> Index(G, S));
  cosets := List(subs, S -> List(RightCosets(G, S), c -> Set(AsList(c))));
  found := false;
  # choose subgroups i1<=i2<=...<=i5 (indices with pairwise gcd <= 4, sum of 1/index <= 1), then disjoint cosets
  rec5 := function(chosen, start, used, sumrec)
    local i, c, newused;
    if found then return; fi;
    if Length(chosen) = 5 then found := true; Print("FOUND in ", StructureDescription(G), " indices ", List(chosen, x -> idx[x[1]]), "\n"); return; fi;
    for i in [start..Length(subs)] do
      if ForAny(chosen, x -> Gcd(idx[x[1]], idx[i]) > 4) then continue; fi;
      if sumrec + 1/idx[i] > 1 then continue; fi;
      for c in [1..Length(cosets[i])] do
        if Length(Intersection(used, cosets[i][c])) > 0 then continue; fi;
        rec5(Concatenation(chosen, [[i,c]]), i, Union(used, cosets[i][c]), sumrec + 1/idx[i]);
        if found then return; fi;
      od;
    od;
  end;
  rec5([], 1, [], 0);
  return found;
end;
for n in [2..120] do
  for k in [1..NrSmallGroups(n)] do
    Search2099(SmallGroup(n,k));
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
