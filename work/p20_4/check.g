# 20.4 (Baechle): cut groups (every x conjugate to x^k or x^-k for all k coprime to o(x)).
# (b) is a Sylow 3-subgroup of a cut group cut?  (c) soluble cut G: does exp(O_p(G)) divide p for p in {5,7}?
IsCut := function(G)
  local c, x, o, k;
  for c in ConjugacyClasses(G) do
    x := Representative(c); o := Order(x);
    for k in [2..o-1] do
      if Gcd(k, o) <> 1 then continue; fi;
      if not (x^k in c or x^-k in c) then return false; fi;
    od;
  od;
  return true;
end;
for n in [2..2000] do
  if NrSmallGroups(n) > 5000 or n in [512,1024,1536] then continue; fi;
  if n mod 3 <> 0 and n mod 25 <> 0 and n mod 49 <> 0 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    if not IsCut(G) then continue; fi;
    if n mod 3 = 0 then
      P := SylowSubgroup(G, 3);
      if not IsCut(P) then Print("20.4(b) COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " Sylow 3 not cut\n"); fi;
    fi;
    if IsSolvable(G) then
      for p in [5,7] do
        if n mod (p^2) = 0 then
          O := PCore(G, p);
          if Exponent(O) mod (p^2) = 0 then Print("20.4(c) COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " exp O_", p, " = ", Exponent(O), "\n"); fi;
        fi;
      od;
    fi;
  od;
  if n mod 100 = 0 then Print("done order ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
