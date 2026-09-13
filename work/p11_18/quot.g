F := FreeGroup("x","y"); x := F.1; y := F.2;
LeftComm := function(u, v, k) local w, i; w := u; for i in [1..k] do w := Comm(w, v); od; return w; end;
G := F / [x^-1 * LeftComm(x, y, 2), y^-1 * LeftComm(y, x, 3)];
Print("G(2,3): searching quotients onto simple groups of order <= 200000 and PSL(2,q), q <= 199\n");
for S in SimpleGroupsIterator(60, 200000) do
  q := GQuotients(G, S);
  if Length(q) > 0 then Print("  QUOTIENT onto ", Name(S), " (", Length(q), " maps)\n"); fi;
od;
Print("  simple groups done\n");
for q in Filtered([5..199], IsPrimePowerInt) do
  S := PSL(2, q);
  if Size(S) <= 200000 then continue; fi;
  h := GQuotients(G, S);
  if Length(h) > 0 then Print("  QUOTIENT onto PSL(2,", q, ") (", Length(h), " maps)\n"); fi;
od;
Print("  PSL(2,q) done\n");
L := LowIndexSubgroupsFpGroup(G, 24);
Print("  subgroups of index <= 24: ", Length(L), "\n");
for H in L do if Index(G,H) > 1 then Print("   index ", Index(G,H), " abelian invariants ", AbelianInvariants(H), "\n"); fi; od;
Print("FINISHED\n"); QUIT;
