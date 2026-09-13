# Problem 21.111 (Revin-Yang): S simple (not Sz(q)), x a nonidentity automorphism; x is a tau-automorphism if
# every two conjugates of x in <x, Inn S> generate a subgroup of order not divisible by 3.
# Since conjugates of x in <x,Inn S> are x^s (s in S), check 3 does not divide |<x, x^s>| for all s in S.
IsTau := function(A, Inn, x)
  local orb, y;
  # conjugates of x under Inn
  orb := Orbit(Inn, x);
  for y in orb do
    if Size(Group(x, y)) mod 3 = 0 then return false; fi;
  od;
  return true;
end;
Analyse := function(S, name)
  local A, iso, Ap, Inn, cls, x, found, c;
  if Size(S) mod 3 <> 0 then Print(name, ": order not divisible by 3 (excluded)\n"); return; fi;
  A := AutomorphismGroup(S);
  iso := IsomorphismPermGroup(A);
  Ap := Image(iso);
  Inn := Image(iso, InnerAutomorphismsAutomorphismGroup(A));
  found := [];
  for c in ConjugacyClasses(Ap) do
    x := Representative(c);
    if IsOne(x) then continue; fi;
    if IsTau(Ap, Inn, x) then
      Add(found, rec(order := Order(x), inner := x in Inn, classsize := Size(c)));
      Print(name, ": TAU automorphism found, order ", Order(x), " inner=", x in Inn, "\n");
    fi;
  od;
  if Length(found) = 0 then Print(name, ": not a tau-group\n"); fi;
end;
