# 19.30: G finite, S simple, |G| = |S|, same set of orders of vanishing elements => G ~= S ?
VanOrders := function(G) local tbl, irr, cls, i;
  tbl := CharacterTable(G); irr := Irr(tbl); cls := ConjugacyClasses(tbl);
  return Set(Filtered([1..Length(cls)], i -> ForAny(irr, chi -> chi[i] = 0)), i -> Order(Representative(cls[i])));
end;
for S in [AlternatingGroup(5), PSL(2,7), AlternatingGroup(6), PSL(2,8), PSL(2,11), PSL(2,13)] do
  vS := VanOrders(S); n := Size(S);
  Print(Size(S), ": vanishing orders ", vS, "\n");
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    if IsSimple(G) then continue; fi;
    if VanOrders(G) = vS then Print("COUNTEREXAMPLE order ", n, " id ", k, " ", StructureDescription(G), "\n"); fi;
  od;
od;
Print("FINISHED\n"); QUIT;
