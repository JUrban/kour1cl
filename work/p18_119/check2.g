# 18.119 targeted sweep: groups with derived length >= 3 and non-nilpotent G'' (Sylow subgroups of w(G) not normal), words delta_2, gamma_3
CommSet := function(A, B) local s, a, b; s := []; for a in A do for b in B do AddSet(s, Comm(a,b)); od; od; return s; end;
for n in [24..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    if DerivedLength(G) < 3 then continue; fi;
    D2 := DerivedSubgroup(DerivedSubgroup(G));
    if IsNilpotent(D2) then continue; fi;
    Els := Elements(G); C := CommSet(Els, Els); W := CommSet(C, C);   # delta_2-values
    V := Subgroup(G, W);
    if Size(V) <> Size(D2) then Print("?? delta2 subgroup mismatch ", [n,k], "\n"); fi;
    for p in PrimeDivisors(Size(V)) do
      P := SylowSubgroup(V, p);
      if IsNormal(V, P) then continue; fi;
      if Size(Subgroup(V, Filtered(W, w -> w in P))) <> Size(P) then
        Print("COUNTEREXAMPLE delta2: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " p=", p, " |P|=", Size(P), " gen by values: ", Size(Subgroup(V, Filtered(W, w -> w in P))), "\n");
      fi;
    od;
    # gamma_3 values
    W3 := CommSet(C, Els); V3 := Subgroup(G, W3);
    for p in PrimeDivisors(Size(V3)) do
      P := SylowSubgroup(V3, p);
      if IsNormal(V3, P) then continue; fi;
      if Size(Subgroup(V3, Filtered(W3, w -> w in P))) <> Size(P) then
        Print("COUNTEREXAMPLE gamma3: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " p=", p, "\n");
      fi;
    od;
  od;
  if n mod 100 = 0 then Print("done order ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
