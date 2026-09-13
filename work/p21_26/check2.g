# 21.26 -- faster exact method via double cosets P\G/P.
# For a Sylow p-subgroup P the minimality of P meet P^x depends only on the double coset PxP
# (P meet P^{axb} = (P meet P^x)^b for a,b in P).
# MinData(G,P): returns record with
#   reps  : double coset representatives r,
#   ints  : P meet P^r,
#   ismin : whether P meet P^r is inclusion-minimal among ALL intersections P meet P^g,
#   minorders : set of orders of inclusion-minimal intersections,
#   zenkov : true iff every inclusion-minimal intersection equals O_p(G).
MinData := function(G, P)
  local dc, reps, ints, n, i, j, ismin, I, J, orbI, b, found, minorders, Op;
  dc := DoubleCosetRepsAndSizes(G, P, P);
  reps := List(dc, x -> x[1]);
  ints := List(reps, r -> Intersection(P, P^r));
  n := Length(reps);
  ismin := List([1..n], i -> true);
  for i in [1..n] do
    I := ints[i];
    # I is non-minimal iff some P-conjugate of some ints[j] is strictly contained in I
    orbI := Set(Orbit(P, I, OnPoints));   # P-conjugates of I; J^b < I  iff  J < I^(b^-1)
    for j in [1..n] do
      J := ints[j];
      if Size(J) < Size(I) and ForAny(orbI, K -> IsSubgroup(K, J)) then
        ismin[i] := false; break;
      fi;
    od;
  od;
  minorders := Set(List(Filtered([1..n], i -> ismin[i]), i -> Size(ints[i])));
  Op := PCore(G, PrimePGroup(P));
  return rec(reps := reps, ints := ints, ismin := ismin, sizes := List(dc, x -> x[2]),
             minorders := minorders,
             zenkov := ForAll(Filtered([1..n], i -> ismin[i]), i -> ints[i] = Op),
             Op := Op, P := P, nmin := Number(ismin, x -> x),
             goodsize := Sum(Filtered([1..n], i -> ismin[i]), i -> dc[i][2]));
end;
# IsGoodElt(md, x): is P meet P^x inclusion-minimal?  (exact: the intersection is minimal iff it
# is a P-conjugate of a minimal representative intersection; by Zenkov's theorem, when md.zenkov
# holds this is just  P meet P^x = O_p(G), which we use when available, otherwise a direct test.)
IsGoodElt := function(md, x)
  local I, i, orbI;
  I := Intersection(md.P, md.P^x);
  if md.zenkov then return I = md.Op; fi;
  if not Size(I) in md.minorders then return false; fi;
  orbI := Set(Orbit(md.P, I, OnPoints));
  for i in [1..Length(md.reps)] do
    if Size(md.ints[i]) < Size(I) and ForAny(orbI, K -> IsSubgroup(K, md.ints[i])) then return false; fi;
  od;
  return true;
end;
# Check2126b(G, samples): returns [answer, x or fail, diagnostics]
Check2126b := function(G, samples)
  local primes, mds, p, P, t, x, good, i, idx, r, b, S, xs, cand, allgood;
  primes := Filtered(PrimeDivisors(Size(G)), p -> not IsNormal(G, SylowSubgroup(G, p)));
  if Length(primes) = 0 then return [true, One(G), "all Sylows normal"]; fi;
  mds := List(primes, p -> MinData(G, SylowSubgroup(G, p)));
  Print("   diagnostics: ");
  for i in [1..Length(primes)] do
    Print(primes[i], ":(dc=", Length(mds[i].reps), ",min=", mds[i].nmin, ",ords=", mds[i].minorders,
          ",|Op|=", Size(mds[i].Op), ",zenkov=", mds[i].zenkov, ",good=", mds[i].goodsize, "/", Size(G), ") ");
  od;
  Print("\n");
  if Length(primes) = 1 then return [true, mds[1].reps[Position(mds[1].ismin, true)], "one non-normal Sylow"]; fi;
  # random sampling
  for t in [1..samples] do
    x := PseudoRandom(G);
    if ForAll(mds, md -> IsGoodElt(md, x)) then return [true, x, Concatenation("random sample ", String(t))]; fi;
  od;
  # exact: enumerate elements of the good double cosets of the prime with the smallest good set
  idx := 1;
  for i in [2..Length(primes)] do if mds[i].goodsize < mds[idx].goodsize then idx := i; fi; od;
  P := mds[idx].P;
  for i in [1..Length(mds[idx].reps)] do
    if not mds[idx].ismin[i] then continue; fi;
    r := mds[idx].reps[i];
    S := Set(List(RightCosets(G, P), c -> Representative(c)));  # unused
    xs := Set(Concatenation(List(Elements(P), a -> List(Elements(P), b -> a*r*b))));
    for x in xs do
      if ForAll([1..Length(mds)], j -> j = idx or IsGoodElt(mds[j], x)) then
        return [true, x, "exact enumeration"];
      fi;
    od;
  od;
  return [false, fail, "exact enumeration: NO common good element"];
end;
