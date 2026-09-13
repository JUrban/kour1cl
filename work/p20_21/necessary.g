# 20.21 necessary condition: K with normal I, K/I ~= V4, an automorphism of K of order 3 stabilising I and
# acting transitively on K/I \ 1, and a normal I' ~= I (abstractly) with K/I' ~= C4.
for n in [4..200] do
  if n mod 4 <> 0 or NrSmallGroups(n) > 3000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    K := SmallGroup(n,k);
    ns := Filtered(NormalSubgroups(K), N -> Index(K,N) = 4);
    Vs := Filtered(ns, N -> not IsCyclic(K/N));
    Cs := Filtered(ns, N -> IsCyclic(K/N));
    if Length(Vs) = 0 or Length(Cs) = 0 then continue; fi;
    A := AutomorphismGroup(K);
    for I in Vs do
      # need an automorphism of order 3 stabilising I acting transitively on K/I - 1
      cand := Filtered(Cs, N -> IdGroup(N) = IdGroup(I));
      if Length(cand) = 0 then continue; fi;
      q := NaturalHomomorphismByNormalSubgroup(K, I);
      ok := false;
      for a in A do
        if Order(a) mod 3 <> 0 then continue; fi;
        if Image(a, I) <> I then continue; fi;
        # induced action on K/I
        elts := Filtered(Elements(Image(q)), x -> not IsOne(x));
        x := elts[1]; pre := PreImagesRepresentative(q, x);
        y := Image(q, Image(a, pre)); z := Image(q, Image(a, Image(a, pre)));
        if Length(Set([x,y,z])) = 3 then ok := true; break; fi;
      od;
      if ok then Print("CANDIDATE K = SmallGroup(", n, ",", k, ") ", StructureDescription(K), " I ~= ", StructureDescription(I), " (I' with cyclic quotient exists)\n"); fi;
    od;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
