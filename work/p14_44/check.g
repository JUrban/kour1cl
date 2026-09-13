# 14.44 (Kazarin-Sangroniz): G = AB, gcd(|A|,|B|)=1  => k(G) <= k(A)k(B) ?
# 14.74 (Pyber): k(G) <= prod k(P_i) over Sylow subgroups?
CheckOrder := function(n)
  local k, G, kG, ccs, sizes, A, B, prod, p, bad;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, k);
    kG := NrConjugacyClasses(G);
    prod := Product(PrimeDivisors(n), p -> NrConjugacyClasses(SylowSubgroup(G, p)));
    if kG > prod then Print("14.74 COUNTEREXAMPLE ", [n,k], " k(G)=", kG, " prod=", prod, "\n"); fi;
    if IsNilpotent(G) then continue; fi;
    ccs := List(ConjugacyClassesSubgroups(G), Representative);
    for A in ccs do
      if Size(A) = 1 or Size(A) = n then continue; fi;
      for B in ccs do
        if Size(A) * Size(B) <> n or Gcd(Size(A), Size(B)) <> 1 then continue; fi;
        # coprime orders with |A||B| = |G| => G = AB automatically
        if kG > NrConjugacyClasses(A) * NrConjugacyClasses(B) then
          Print("14.44 COUNTEREXAMPLE ", [n,k], " |A|=", Size(A), " |B|=", Size(B), " k(G)=", kG, " k(A)k(B)=", NrConjugacyClasses(A)*NrConjugacyClasses(B), "\n");
        fi;
      od;
    od;
  od;
  Print("done order ", n, "\n");
end;
for n in [2..600] do if not IsPrimePowerInt(n) and not n in [512] then CheckOrder(n); fi; od;
Print("FINISHED\n"); QUIT;
