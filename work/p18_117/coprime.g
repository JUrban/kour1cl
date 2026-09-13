# 18.117 (Shumyatsky): is every element of a non-abelian finite simple group a commutator [x,y] with gcd(|x|,|y|) = 1?
# Randomised verification for a given permutation group G: for each class C find coprime x,y with [x,y] in C.
CheckCoprimeCommutators := function(G, name, budget)
  local cls, n, hit, ords, i, tries, x, y, g, pos, remaining, ordreps, X, Y, a, b;
  cls := ConjugacyClasses(G); n := Length(cls);
  hit := List(cls, c -> false);
  hit[Position(cls, ConjugacyClass(G, One(G)))] := true;   # identity = [1,1]
  ordreps := Set(List(cls, c -> Order(Representative(c))));
  tries := 0;
  while tries < budget and not ForAll(hit, x -> x) do
    tries := tries + 1;
    x := PseudoRandom(G); y := PseudoRandom(G);
    if Gcd(Order(x), Order(y)) <> 1 then continue; fi;
    g := Comm(x, y);
    pos := First([1..n], i -> not hit[i] and g in cls[i]);
    if pos <> fail then hit[pos] := true; fi;
  od;
  remaining := Filtered([1..n], i -> not hit[i]);
  Print(name, ": classes ", n, ", not yet realised as coprime commutators: ", List(remaining, i -> [Order(Representative(cls[i])), Size(cls[i])]), " (", tries, " random pairs)\n");
  return remaining;
end;
