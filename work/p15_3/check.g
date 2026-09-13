# 15.3 (Isaacs): solvable G with faithful non-linear irreducible alpha, beta such that alpha*beta is irreducible?
for n in [2..600] do
  if NrSmallGroups(n) > 3000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if not IsSolvable(G) or IsAbelian(G) then continue; fi;
    tbl := CharacterTable(G); irr := Irr(tbl);
    faith := Filtered(irr, chi -> chi[1] > 1 and Size(KernelOfCharacter(chi)) = 1);
    for i in [1..Length(faith)] do for j in [i..Length(faith)] do
      a := faith[i]; b := faith[j];
      if n mod (a[1]*b[1]) <> 0 then continue; fi;
      prod := List([1..Length(a)], t -> a[t]*b[t]);
      if ScalarProduct(tbl, prod, prod) = 1 then Print("FOUND: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " degrees ", a[1], " ", b[1], "\n"); fi;
    od; od;
  od;
  if n mod 50 = 0 then Print("done order ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
