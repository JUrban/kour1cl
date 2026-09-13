# 20.122 (Zenkov): nilpotent A, B, C <= G.  Min_G(A,B,C) = < inclusion-minimal A meet B^x meet C^y >,
# min_G(A,B,C) = < those of minimal order >.  Is min <= F(G)?  Is Min <= F(G)?
# Intersections up to A-conjugacy: x over reps of B\G/A, y over reps of C\G/(A meet B^x).
Inters := function(G, A, B, C)
  local res, x, Ix, y, J;
  res := [];
  for x in List(DoubleCosetRepsAndSizes(G, B, A), t -> t[1]) do
    Ix := Intersection(A, B^x);
    for y in List(DoubleCosetRepsAndSizes(G, C, Ix), t -> t[1]) do
      J := Intersection(Ix, C^y);
      if not J in res then Add(res, J); fi;
    od;
  od;
  return res;
end;
MinData := function(G, A, B, C)
  local S, n, ismin, i, j, orbI, minord, mins, minords, F;
  S := Inters(G, A, B, C); n := Length(S);
  ismin := List([1..n], i -> true);
  for i in [1..n] do
    orbI := Set(Orbit(A, S[i], OnPoints));
    for j in [1..n] do
      if Size(S[j]) < Size(S[i]) and ForAny(orbI, K -> IsSubgroup(K, S[j])) then ismin[i] := false; break; fi;
    od;
  od;
  mins := Filtered([1..n], i -> ismin[i]);
  minord := Minimum(List(S, Size));
  minords := Filtered([1..n], i -> Size(S[i]) = minord);
  F := FittingSubgroup(G);
  return rec(minOK := ForAll(minords, i -> IsSubgroup(F, S[i])),
             MinOK := ForAll(mins, i -> IsSubgroup(F, S[i])),
             minord := minord, nmin := Length(mins), sizes := Set(List(mins, i -> Size(S[i]))));
end;
CheckGroup := function(G, name)
  local nil, ps, P, triples, t, r, F;
  ps := PrimeDivisors(Size(G));
  nil := List(ps, p -> SylowSubgroup(G, p));
  F := FittingSubgroup(G);
  if not IsNilpotent(G) and Size(F) > 1 and not F in nil then Add(nil, F); fi;
  nil := Filtered(nil, N -> not IsNormal(G, N));   # normal nilpotent subgroups only give intersections inside F(G)? (A normal => A meet B^x meet C^y ... keep only non-normal A for speed, but B, C may be normal)
  for A in nil do
    for B in Concatenation(nil, Filtered([F], N -> Size(N) > 1)) do
      for C in Concatenation(nil, Filtered([F], N -> Size(N) > 1)) do
        r := MinData(G, A, B, C);
        if not r.minOK then Print("COUNTEREXAMPLE(a) ", name, " soluble=", IsSolvableGroup(G), " ", StructureDescription(G), " A=", StructureDescription(A), " B=", StructureDescription(B), " C=", StructureDescription(C), " minord=", r.minord, " sizes of Min: ", r.sizes, "\n"); fi;
        if not r.MinOK then Print("COUNTEREXAMPLE(b) ", name, " soluble=", IsSolvableGroup(G), " ", StructureDescription(G), " A=", StructureDescription(A), " B=", StructureDescription(B), " C=", StructureDescription(C), " minord=", r.minord, " sizes of Min: ", r.sizes, "\n"); fi;
      od;
    od;
  od;
end;
for n in [6..400] do
  if Length(PrimeDivisors(n)) < 2 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsNilpotent(G) then continue; fi;
    CheckGroup(G, Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
