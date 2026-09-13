Read("/project/work/p18_117/coprime.g");
# Targeted search for a class C: find x with xg ~ x (g in C) and a conjugating element y of order coprime to |x|.
Targeted := function(G, g, budget)
  local tries, x, a, y0, C, c, y, k;
  tries := 0;
  while tries < budget do
    tries := tries + 1;
    x := PseudoRandom(G); a := Order(x);
    if Gcd(a, Order(g)) = 1 and false then fi;
    if not IsConjugate(G, x, x*g) then continue; fi;
    y0 := RepresentativeAction(G, x, x*g);
    C := Centralizer(G, x);
    for k in [1..200] do
      c := PseudoRandom(C); y := c*y0;
      if Gcd(Order(y), a) = 1 then
        if Comm(x, y) <> g then Error("bug"); fi;
        return [x, y];
      fi;
    od;
  od;
  return fail;
end;
FullCheck := function(G, name, budget1, budget2)
  local rem, cls, i, r;
  rem := CheckCoprimeCommutators(G, name, budget1);
  cls := ConjugacyClasses(G);
  for i in rem do
    r := Targeted(G, Representative(cls[i]), budget2);
    if r = fail then Print(name, ": class of order ", Order(Representative(cls[i])), " size ", Size(cls[i]), " STILL OPEN\n");
    else Print(name, ": class of order ", Order(Representative(cls[i])), " size ", Size(cls[i]), " realised: |x|=", Order(r[1]), " |y|=", Order(r[2]), "\n"); fi;
  od;
end;
