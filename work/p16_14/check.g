# 16.14 (Berkovich): finite 2-group G with Omega_1(G) <= Z(G): rank(G/G^2) <= 2 rank(Z(G)) ?
CheckOrder := function(n)
  local k, G, Z, Om, d, rZ, cnt;
  cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, k);
    if IsAbelian(G) then continue; fi;
    Z := Center(G);
    Om := Omega(G, 2, 1);
    if not IsSubgroup(Z, Om) then continue; fi;
    cnt := cnt + 1;
    d := Length(AbelianInvariants(G / DerivedSubgroup(G)));   # rank of G/G^2 = d(G) for p-groups
    d := RankPGroup(G);
    rZ := Length(Filtered(AbelianInvariants(Z), x -> x mod 2 = 0));  # rank of Z(G)
    if d > 2 * rZ then Print("COUNTEREXAMPLE ", [n,k], " d(G)=", d, " rank Z=", rZ, "\n"); fi;
  od;
  Print("done order ", n, " groups with Omega1<=Z: ", cnt, "\n");
end;
for n in [8, 16, 32, 64, 128, 256] do CheckOrder(n); od;
Print("FINISHED\n"); QUIT;
