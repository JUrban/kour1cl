# 20.21 (Verret/Conder): G with normal K, L of index 12, K ~= L, G/K ~= C12, G/L ~= A4 ?
for n in [12..2000] do
  if n mod 12 <> 0 or n in [1536] or NrSmallGroups(n) > 30000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    ab := AbelianInvariants(G);
    # need C12 quotient: G/G' has an element of order 12
    if not (Exponent(G/DerivedSubgroup(G)) mod 12 = 0) then continue; fi;
    ns := Filtered(NormalSubgroups(G), N -> Index(G,N) = 12);
    Ks := Filtered(ns, N -> IsCyclic(G/N));
    Ls := Filtered(ns, N -> IdGroup(G/N) = [12,3]);
    if Length(Ks) = 0 or Length(Ls) = 0 then continue; fi;
    for K in Ks do for L in Ls do
      if IdGroup(K) = IdGroup(L) then Print("FOUND: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " K ~= L ~= ", StructureDescription(K), "\n"); fi;
    od; od;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
