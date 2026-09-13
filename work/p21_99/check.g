# Problem 21.99 (P. Mueller's conjecture): G transitive on Omega finite. For distinct alpha, beta
# is there g with alpha^g = beta and |Fix(g)| <> 1 ?
# Fix alpha = 1; beta ranges over G_1-orbit representatives on Omega\{1}.
# p-groups of degree p^k > 1 satisfy it automatically (fixed points = degree mod p).
NrFix := function(g, n) return Number([1..n], x -> x^g = x); end;
Check2199 := function(G, n)
  local stab, orbs, b, t, found, h, bad, elts, tries;
  stab := Stabilizer(G, 1);
  orbs := Orbits(stab, [2..n]);
  bad := [];
  for b in List(orbs, o -> o[1]) do
    t := RepresentativeAction(G, 1, b);
    found := false;
    if Size(stab) <= 3000 then
      for h in stab do
        if NrFix(h*t, n) <> 1 then found := true; break; fi;
      od;
    else
      tries := 0;
      while not found and tries < 500 do
        h := PseudoRandom(stab);
        if NrFix(h*t, n) <> 1 then found := true; fi;
        tries := tries + 1;
      od;
      if not found then
        Print("  (falling back to full enumeration for a group of order ", Size(G), ")\n");
        for h in stab do
          if NrFix(h*t, n) <> 1 then found := true; break; fi;
        od;
      fi;
    fi;
    if not found then Add(bad, b); fi;
  od;
  return bad;
end;
RunDegrees := function(lo, hi)
  local n, k, G, res, cnt, skipped;
  for n in [lo..hi] do
    cnt := 0; skipped := 0;
    for k in [1..NrTransitiveGroups(n)] do
      G := TransitiveGroup(n, k);
      if IsPrimePowerInt(n) and IsPrimePowerInt(Size(G)) then skipped := skipped + 1; continue; fi;
      res := Check2199(G, n);
      cnt := cnt + 1;
      if Length(res) > 0 then
        Print("COUNTEREXAMPLE: TransitiveGroup(", n, ",", k, ") = ", G, " size ", Size(G), " bad betas ", res, "\n");
      fi;
    od;
    Print("done degree ", n, ": checked ", cnt, " groups, skipped ", skipped, " p-groups\n");
  od;
  Print("FINISHED degrees ", lo, "..", hi, "\n");
end;
