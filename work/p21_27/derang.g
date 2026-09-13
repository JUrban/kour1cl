# Problem 21.27: G finite simple transitive permutation group; is every element a product of two derangements?
# Problem 21.28: proportion of derangements >= 89/325 ?
# For each simple G and each conjugacy class of proper subgroups H (core-free automatically), consider action on G/H.
# Derangements = elements not conjugate into H. Products of two derangements: use class algebra.
CheckActions := function(G, name)
  local tbl, cls, n, H, ccs, derangCls, i, j, k, sizes, prodOK, x, y, t, fus, dset, elts, ok, cnt, ders, minprop, prop, dsize, ind, ccl, csizes, structconst, bad;
  tbl := CharacterTable(G);
  cls := ConjugacyClasses(tbl);
  n := Length(cls);
  csizes := SizesConjugacyClasses(tbl);
  minprop := 1;
  ccs := List(ConjugacyClassesSubgroups(G), Representative);
  ccs := Filtered(ccs, H -> Size(H) < Size(G) and Size(H) > 1);
  for H in ccs do
    # which classes of G meet H
    fus := Set(List(ConjugacyClasses(H), c -> First([1..n], i -> Representative(c) in cls[i])));
    # more robust: for each class of G test whether some element lies in H via fusion of H's classes
    ders := Filtered([1..n], i -> not i in fus);
    if Length(ders) = 0 then continue; fi;
    dsize := Sum(csizes{ders});
    prop := dsize / Size(G);
    if prop < minprop then minprop := prop; fi;
    if prop < 89/325 then Print("21.28 COUNTEREXAMPLE? ", name, " H of order ", Size(H), " index ", Index(G,H), " derangement proportion ", prop, "\n"); fi;
    # products of two derangements: class k is a product of classes i,j (i,j derangement classes) iff structure constant > 0
    bad := [];
    for k in [1..n] do
      ok := false;
      for i in ders do
        for j in ders do
          if ClassMultiplicationCoefficient(tbl, i, j, k) > 0 then ok := true; break; fi;
        od;
        if ok then break; fi;
      od;
      if not ok then Add(bad, k); fi;
    od;
    if Length(bad) > 0 then Print("21.27 COUNTEREXAMPLE: ", name, " H of order ", Size(H), " index ", Index(G,H), " classes not product of two derangements: ", bad, " orders ", OrdersClassRepresentatives(tbl){bad}, "\n"); fi;
  od;
  Print("done ", name, " min derangement proportion over all actions = ", minprop, " (89/325 = ", Float(89/325), ")\n");
end;
for G in SimpleGroupsIterator(60, 500000) do CheckActions(G, Name(G)); od;
Print("FINISHED\n"); QUIT;
