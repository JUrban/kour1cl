n := 0;; tot := 0;;
for k in [1..511] do
  if k > 1 then
    tot := tot + NrSmallGroups(k);
    n := n + Number([1..NrSmallGroups(k)], i -> not IsAbelian(SmallGroup(k,i)));
  fi;
od;
Print("nonabelian groups of order <= 511: ", n, " (all groups: ", tot, ")\n");
Print("transitive groups of degrees 2..20: ", Sum([2..20], d -> NrTransitiveGroups(d)), "\n");
Print("nr of ordinary character tables in CTblLib: n/a\n");
QUIT;
