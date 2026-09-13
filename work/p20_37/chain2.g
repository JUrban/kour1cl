# 20.37: chain-achievable sizes enlarged by Theorem 1:  if H <= K, |K:H| even and K = <H, x> for some x, then 2|H| in L(K).
# L2(G) := closure of {1,|G|} u U_M (L2(M) u |G:M| L2(M)) u {2|H|, |G|/(2|H|) : H <= G, |G:H| even, exists x: <H,x> = G}.
memo2 := NewDictionary(fail, true);
ExistsCoGen := function(G, H)   # is there x with <H, x> = G ?  (random search, then exact via maximal subgroups)
  local i, x, maxs;
  if Size(H) = Size(G) then return false; fi;
  for i in [1..60] do
    x := Random(G);
    if Size(ClosureGroup(H, x)) = Size(G) then return true; fi;
  od;
  # exact: G = <H,x> for some x iff the maximal subgroups containing H do not cover G
  maxs := Filtered(MaximalSubgroupClassReps(G), M -> Size(M) mod Size(H) = 0);
  maxs := Concatenation(List(maxs, M -> Filtered(AsList(ConjugacyClassSubgroups(G, M)), C -> IsSubgroup(C, H))));
  return Sum(List(maxs, Size)) < Size(G) or ForAny(Elements(G), x -> not ForAny(maxs, M -> x in M));
end;
L2set := function(G)
  local key, res, M, LM, n, a, mx, H, cls;
  n := Size(G);
  if n = 1 then return [1]; fi;
  key := fail;
  if n <= 2000 and not n in [512, 1024, 1536] then key := IdGroup(G); fi;
  if key <> fail then res := LookupDictionary(memo2, key); if res <> fail then return res; fi; fi;
  res := [1, n];
  for M in MaximalSubgroupClassReps(G) do
    LM := L2set(M); mx := n / Size(M);
    for a in LM do AddSet(res, a); AddSet(res, mx * a); AddSet(res, n / a); AddSet(res, n / (mx * a)); od;
  od;
  cls := List(ConjugacyClassesSubgroups(G), Representative);
  for H in cls do
    if Size(H) < n and (n / Size(H)) mod 2 = 0 and not (2 * Size(H)) in res and ExistsCoGen(G, H) then
      AddSet(res, 2 * Size(H)); AddSet(res, n / (2 * Size(H)));
    fi;
  od;
  if key <> fail then AddDictionary(memo2, key, res); fi;
  return res;
end;
Missing2 := function(G) return Difference(DivisorsInt(Size(G)), L2set(G)); end;
