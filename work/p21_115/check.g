# Problem 21.115 (Sambale): C_1..C_n cosets (left or right) of a finite group G with U = union <> G.
# Is |G \ U| >= |G|/2^n always?  Search for counterexamples: n cosets, WLOG 1 not in U (translate),
# subgroups H_1,..,H_n (multiset) with sum |H_i| > (1-2^-n)|G| (necessary), cosets g_i H_i with g_i notin H_i.
# Left cosets suffice by symmetry (inversion maps left cosets to right cosets) -- actually the problem allows
# mixing left and right cosets; we handle both: a right coset H g = g (g^-1 H g) is a left coset of a conjugate,
# so the set of all left cosets of all subgroups already contains all right cosets. So left cosets only.
SearchGroup := function(G, nmax)
  local n, subs, sizes, elts, cosetsOf, H, cs, g, recurse, order, found, best, bound;
  order := Size(G);
  elts := AsSSortedList(G);
  subs := Filtered(List(ConjugacyClassesSubgroups(G), Representative), H -> Size(H) < order);
  # we need all subgroups (not up to conjugacy) since cosets of different conjugates interact
  subs := Concatenation(List(subs, H -> AsList(ConjugacyClassSubgroups(G, H))));
  SortBy(subs, H -> -Size(H));
  # cosets not containing 1 for each subgroup, as sorted lists
  cosetsOf := List(subs, H -> List(Filtered(RightCosets(G, H), c -> not One(G) in c), c -> Set(AsList(c))));
  # right cosets Hg; left cosets gH = (H^g) g are right cosets of conjugates, all subgroups included -> fine
  found := [];
  for n in [1..nmax] do
    bound := order / 2^n;
    recurse := function(start, k, union, sumsizes)
      local i, c, newU;
      if k = n then
        if order - Length(union) < bound then
          Add(found, rec(n := n, complement := order - Length(union)));
          Print("COUNTEREXAMPLE in ", StructureDescription(G), " n=", n, " |complement|=", order - Length(union), " < ", bound, "\n");
        fi;
        return;
      fi;
      for i in [start..Length(subs)] do
        # pruning: remaining k..n-1 cosets each of size <= |subs[i]|
        if sumsizes + (n - k) * Size(subs[i]) <= (1 - 1/2^n) * order then return; fi;
        for c in cosetsOf[i] do
          newU := Union(union, c);
          recurse(i, k + 1, newU, sumsizes + Size(subs[i]));
        od;
      od;
    end;
    recurse(1, 0, [], 0);
  od;
  return found;
end;
