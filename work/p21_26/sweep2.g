Read("/project/work/p21_26/check2.g");
heavy := [768,1024,1152,1536,1728,1920,1280,1792];
RunOrders2 := function(lo, hi)
  local n, k, G, cnt, r, primes;
  cnt := 0;
  for n in [lo..hi] do
    if Length(PrimeDivisors(n)) < 2 or n in heavy then continue; fi;
    for k in [1..NrSmallGroups(n)] do
      G := SmallGroup(n, k);
      if IsNilpotent(G) then continue; fi;
      primes := Filtered(PrimeDivisors(n), p -> not IsNormal(G, SylowSubgroup(G, p)));
      if Length(primes) < 2 then continue; fi;
      cnt := cnt + 1;
      r := Check2126b(G, 50);
      if not r[1] then Print("COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), "\n"); fi;
    od;
    Print("done order ", n, " total groups with >=2 non-normal Sylows checked ", cnt, "\n");
  od;
  Print("FINISHED ", lo, "..", hi, "\n");
end;
