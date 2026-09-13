# 16.14: among 2-groups with Omega_1(G) <= Z(G), tabulate (d(G), r = rank Omega_1(G)) and list extremal ones d = 2r
Rk := function(G) return Length(AbelianInvariants(Omega(G,2))); end;
for n in [2,4,8,16,32,64,128,256] do
  stats := rec(); ext := [];
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    O := Omega(G,2);
    if not IsSubgroup(Centre(G), O) then continue; fi;
    d := Length(AbelianInvariants(G/FrattiniSubgroup(G)));  # d(G) = rank of G/Phi(G)
    r := Length(AbelianInvariants(O));
    key := Concatenation(String(d), ",", String(r));
    if not IsBound(stats.(key)) then stats.(key) := 0; fi;
    stats.(key) := stats.(key) + 1;
    if d = 2*r then Add(ext, [k, d, r, NilpotencyClassOfGroup(G), Exponent(G), StructureDescription(G)]); fi;
  od;
  Print("order ", n, ": ", stats, "\n");
  Print("  extremal d=2r: ", Length(ext), "\n");
  for e in ext do Print("    ", e, "\n"); od;
od;
QUIT;
