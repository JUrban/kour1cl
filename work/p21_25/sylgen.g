# Problem 21.25 (Breuer-Guralnick): G simple, p1,p2 primes dividing |G| (possibly equal): exist Sylow
# p_i-subgroups H_i with G = <H1, H2> ?
Check := function(G, name)
  local primes, p, q, P, Qs, ok, Q, bad;
  primes := PrimeDivisors(Size(G));
  bad := [];
  for p in primes do
    P := SylowSubgroup(G, p);
    for q in primes do
      if q < p then continue; fi;
      Qs := ConjugacyClassSubgroups(G, SylowSubgroup(G, q));
      ok := ForAny(Qs, Q -> Index(G, ClosureGroup(P, Q)) = 1);
      if not ok then Add(bad, [p,q]); fi;
    od;
  od;
  if Length(bad) > 0 then Print("COUNTEREXAMPLE ", name, " bad prime pairs ", bad, "\n");
  else Print("ok ", name, "\n"); fi;
end;
for G in SimpleGroupsIterator(60, 2000000) do Check(G, Name(G)); od;
Print("FINISHED\n"); QUIT;
