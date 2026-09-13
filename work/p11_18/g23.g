# 11.18 (Brandl): G(a,b) = <x,y | x = [x, _a y], y = [y, _b x]>. Case (2,3).
F := FreeGroup("x","y"); x := F.1; y := F.2;
LeftComm := function(u, v, k) local w, i; w := u; for i in [1..k] do w := Comm(w, v); od; return w; end;
MakeG := function(a, b)
  return F / [x^-1 * LeftComm(x, y, a), y^-1 * LeftComm(y, x, b)];
end;
for ab in [[2,3],[3,2],[2,4],[3,3],[4,2],[2,5]] do
  G := MakeG(ab[1], ab[2]);
  Print("G", ab, ": abelian invariants ", AbelianInvariants(G), "\n");
  # try nilpotent / low index quotients
  L := LowIndexSubgroupsFpGroup(G, 12);
  Print("  number of subgroups of index <= 12: ", Length(L), "\n");
  for H in L do
    ai := AbelianInvariants(H);
    if 0 in ai then Print("  INFINITE: subgroup of index ", Index(G, H), " has abelianisation ", ai, "\n"); break; fi;
  od;
  # quotients onto small simple groups
  for S in [AlternatingGroup(5), PSL(2,7), AlternatingGroup(6), PSL(2,8), PSL(2,11), PSL(2,13), PSL(3,3), PSU(3,3), MathieuGroup(11)] do
    q := GQuotients(G, S);
    if Length(q) > 0 then Print("  quotient onto ", Name(S), " (", Length(q), " maps)\n"); fi;
  od;
  # coset enumeration with a bounded table
  s := fail;
  # try CosetTableFromGensAndRels with limit
  CosetTableDefaultMaxLimit := 5000000;
  t := CosetTableFromGensAndRels(FreeGeneratorsOfFpGroup(G), RelatorsOfFpGroup(G), [] : max := 5000000, silent := true);
  if t <> fail then Print("  FINITE of order ", Length(t[1]), "\n"); else Print("  coset enumeration (5M) failed\n"); fi;
od;
QUIT;
