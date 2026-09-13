# 19.56 (Monakhov): star-commutator = [x,y] with x, y of coprime prime-power orders.
# Hypothesis H(G): for all star-commutators a, b of coprime orders, |ab| >= |a||b|.  Is G then soluble?
StarComms := function(G)
  local cls, reps, S, x, y, cx, cy, ppe;
  ppe := Filtered(List(ConjugacyClasses(G), Representative), r -> IsPrimePowerInt(Order(r)));
  S := [];
  for x in ppe do
    for cy in ConjugacyClasses(G) do
      y := Representative(cy);
      if not IsPrimePowerInt(Order(y)) or Gcd(Order(x), Order(y)) <> 1 then continue; fi;
      # all commutators [x, y^g]: iterate over the class of y
      for y in AsList(cy) do AddSet(S, Comm(x, y)); od;
    od;
  od;
  return S;   # closed under conjugation (since x ranges over class reps and y over full classes; [x^g, y^g] = [x,y]^g)
end;
Violates := function(G)   # returns a violating pair or fail
  local S, a, b, o;
  S := Filtered(StarComms(G), s -> not IsOne(s));
  for a in S do for b in S do
    if Gcd(Order(a), Order(b)) = 1 and Order(a*b) < Order(a)*Order(b) then return [a, b]; fi;
  od; od;
  return fail;
end;
CheckList := function(list, tag)
  local G, v;
  for G in list do
    if IsSolvableGroup(G) then continue; fi;
    v := Violates(G);
    if v = fail then Print("COUNTEREXAMPLE (non-soluble group satisfying the hypothesis): ", tag, " ", StructureDescription(G), " order ", Size(G), "\n");
    else Print(tag, " ", StructureDescription(G), " |G|=", Size(G), " violated by |a|=", Order(v[1]), " |b|=", Order(v[2]), " |ab|=", Order(v[1]*v[2]), "\n"); fi;
  od;
end;
CheckList([SL(2,5), SL(2,7), SL(2,9), PSL(2,8), PSL(2,11), SL(2,11), Sz(8), PSL(3,3), PSL(2,27), PSL(2,16), PSL(2,32), PSL(2,13), SL(2,13), PSL(2,17), PSL(2,19), SL(2,19), PSL(2,23), PSL(2,25), PSL(2,64)], "S");
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  CheckList(List([1..NrSmallGroups(n)], k -> SmallGroup(n,k)), Concatenation("order ", String(n)));
  if n mod 200 = 0 then Print("done ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
