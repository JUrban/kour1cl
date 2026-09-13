# 18.77 (Passman): p-group, p^e max irreducible degree, p > e => intersection of kernels of degree-p^e irreducibles trivial?
CheckOrder := function(n)
  local p, k, G, tbl, irr, m, e, K, chi, cnt;
  p := PrimeDivisors(n)[1]; cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    tbl := CharacterTable(G); irr := Irr(tbl);
    m := Maximum(List(irr, x -> x[1])); e := LogInt(m, p);
    if p <= e then continue; fi;
    cnt := cnt + 1;
    K := G;
    for chi in irr do if chi[1] = m then K := Intersection(K, KernelOfCharacter(chi)); fi; od;
    if Size(K) > 1 then Print("COUNTEREXAMPLE SmallGroup(", n, ",", k, ") ", " max degree ", m, " kernel intersection order ", Size(K), "\n"); fi;
  od;
  Print("done order ", n, " tested ", cnt, "\n");
end;
for n in [8,16,32,64,128,256, 27,81,243,729,2187, 125,625,3125,15625, 343,2401,16807, 1331, 14641, 2197] do CheckOrder(n); od;
Print("FINISHED\n"); QUIT;
