# Problem 21.26 (Lisi-Sabatini): G finite, p_1..p_k primes dividing |G|, H_i Sylow p_i-subgroups.
# Is there x in G with H_i meet H_i^x inclusion-minimal in {H_i meet H_i^g : g in G} for ALL i simultaneously?
GoodElements := function(G, H)
  # returns the set of g in G such that H meet H^g is inclusion-minimal among all such intersections
  local elts, ints, i, mins, good, g, I, isMin, j;
  if IsNormal(G, H) then return Elements(G); fi;
  elts := Elements(G);
  ints := List(elts, g -> Intersection(H, H^g));
  # distinct intersections
  mins := [];
  for I in Set(ints) do
    isMin := true;
    for j in Set(ints) do
      if j <> I and IsSubgroup(I, j) then isMin := false; break; fi;
    od;
    if isMin then Add(mins, I); fi;
  od;
  good := Filtered([1..Length(elts)], i -> ints[i] in mins);
  return Set(elts{good});
end;
Check2126 := function(G)
  local primes, p, H, S, good;
  primes := PrimeDivisors(Size(G));
  if Length(primes) < 2 then return true; fi;
  S := fail;
  for p in primes do
    H := SylowSubgroup(G, p);
    good := GoodElements(G, H);
    if S = fail then S := good; else S := Intersection(S, good); fi;
    if Length(S) = 0 then return false; fi;
  od;
  return true;
end;
RunOrders := function(lo, hi)
  local n, k, G, cnt;
  cnt := 0;
  for n in [lo..hi] do
    if Length(PrimeDivisors(n)) < 2 then continue; fi;
    if n in [512,1024,1536] then continue; fi;
    for k in [1..NrSmallGroups(n)] do
      G := SmallGroup(n, k);
      if IsNilpotent(G) then continue; fi;   # all Sylows normal: trivial
      cnt := cnt + 1;
      if not Check2126(G) then
        Print("COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), "\n");
      fi;
    od;
    Print("done order ", n, " total non-nilpotent groups checked ", cnt, "\n");
  od;
  Print("FINISHED ", lo, "..", hi, "\n");
end;
