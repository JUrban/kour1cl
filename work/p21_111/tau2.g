# Optimised tau-check (problem 21.111). x in Aut(S) (perm group Ap), Inn = image of Inn(S).
# x is tau iff for all s in Inn: 3 does not divide |<x, x^s>|.
IsTau2 := function(Ap, Inn, x)
  local i, s, y, orb;
  # quick random rejection
  for i in [1..300] do
    s := PseudoRandom(Inn); y := x^s;
    if Order(x) = 2 then
      if Order(x*y) mod 3 = 0 then return false; fi;
    else
      if Size(Group(x, y)) mod 3 = 0 then return false; fi;
    fi;
  od;
  # full check over the Inn-orbit of x
  orb := Orbit(Inn, x);
  for y in orb do
    if Order(x) = 2 then
      if Order(x*y) mod 3 = 0 then return false; fi;
    else
      if Size(Group(x, y)) mod 3 = 0 then return false; fi;
    fi;
  od;
  return true;
end;
Analyse2 := function(S, name)
  local A, iso, Ap, Inn, cls, x, found, c;
  if Size(S) mod 3 <> 0 then Print(name, ": order not divisible by 3 (excluded)\n"); return; fi;
  A := AutomorphismGroup(S);
  iso := IsomorphismPermGroup(A);
  Ap := Image(iso);
  Inn := Image(iso, InnerAutomorphismsAutomorphismGroup(A));
  found := 0;
  for c in ConjugacyClasses(Ap) do
    x := Representative(c);
    if IsOne(x) or Order(x) mod 3 = 0 then continue; fi;
    if IsTau2(Ap, Inn, x) then
      found := found + 1;
      Print(name, ": TAU automorphism found, order ", Order(x), " inner=", x in Inn, " |Aut-class|=", Size(c), "\n");
    fi;
  od;
  if found = 0 then Print(name, ": not a tau-group\n"); fi;
end;
