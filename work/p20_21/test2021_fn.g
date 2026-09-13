Test2021 := function(K)
  local ns, Vs, Cs, A, S3, elts3, I, cand, q, x, pre, y, z, a, found;
  ns := Filtered(NormalSubgroups(K), N -> Index(K,N) = 4);
  Vs := Filtered(ns, N -> not IsCyclic(K/N));
  Cs := Filtered(ns, N -> IsCyclic(K/N));
  if Length(Vs) = 0 or Length(Cs) = 0 then return false; fi;
  Vs := Filtered(Vs, I -> ForAny(Cs, N -> IdGroup(N) = IdGroup(I)));
  if Length(Vs) = 0 then return false; fi;
  A := AutomorphismGroup(K);
  if Size(A) mod 3 <> 0 then return false; fi;
  S3 := SylowSubgroup(A, 3);
  elts3 := Filtered(Elements(S3), a -> not IsOne(a));   # any 3-power order (an order-3 automorphism need not exist)
  found := false;
  for I in Vs do
    q := NaturalHomomorphismByNormalSubgroup(K, I);
    for a in elts3 do
      if Image(a, I) <> I then continue; fi;
      x := First(Elements(Image(q)), t -> not IsOne(t)); pre := PreImagesRepresentative(q, x);
      y := Image(q, Image(a, pre)); z := Image(q, Image(a, Image(a, pre)));
      if Length(Set([x,y,z])) = 3 then found := true; Print("CANDIDATE K = ", IdGroup(K), " ", StructureDescription(K), " I ~= ", StructureDescription(I), "\n"); break; fi;
    od;
  od;
  return found;
end;
