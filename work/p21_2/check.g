# 21.2 (Amiri): bijection f: G -> S (simple) with |x| dividing |f(x)| for all x. Must G be simple?
# For fixed S and G of the same order: existence of such a bijection is a bipartite matching between order classes:
# Hall's condition: for every set T of element orders of G, #{x in G : |x| in T} <= #{y in S : |y| divisible by some d in T}.
OrderStats := function(G) local c, r; r := rec(); for c in ConjugacyClasses(G) do
  if not IsBound(r.(Order(Representative(c)))) then r.(Order(Representative(c))) := 0; fi;
  r.(Order(Representative(c))) := r.(Order(Representative(c))) + Size(c); od; return r; end;
HasBijection := function(sG, sS)
  local dG, dS, T, lhs, rhs, sub;
  dG := List(RecNames(sG), Int); dS := List(RecNames(sS), Int);
  for sub in Combinations(dG) do
    if Length(sub) = 0 then continue; fi;
    lhs := Sum(sub, d -> sG.(String(d)));
    rhs := Sum(Filtered(dS, e -> ForAny(sub, d -> e mod d = 0)), e -> sS.(String(e)));
    if lhs > rhs then return false; fi;
  od;
  return true;
end;
for S in [AlternatingGroup(5), PSL(2,7), AlternatingGroup(6), PSL(2,8), PSL(2,11), PSL(2,13)] do
  n := Size(S); sS := OrderStats(S); cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsSimple(G) then continue; fi;
    if HasBijection(OrderStats(G), sS) then Print("COUNTEREXAMPLE: order ", n, " id ", k, " ", StructureDescription(G), " admits an order-divisibility bijection onto the simple group\n"); cnt := cnt + 1; fi;
  od;
  Print("order ", n, " done, non-simple groups admitting a bijection: ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
