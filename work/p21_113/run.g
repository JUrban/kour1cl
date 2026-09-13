Read("/project/work/p21_113/psi_check.g");
CheckRange := function(lo, hi)
  local n, k, G, p, bad, total;
  total := 0;
  for n in [lo..hi] do
    if n in [512, 1024, 1536] then continue; fi;
    for k in [1..NrSmallGroups(n)] do
      G := SmallGroup(n, k);
      for p in PrimeDivisors(n) do
        bad := PsiCheck(G, p);
        total := total + 1;
        if Length(bad) > 0 then
          Print("COUNTEREXAMPLE? SmallGroup(", n, ",", k, ") p=", p, " bad inner products: ", bad, "\n");
        fi;
      od;
    od;
    Print("done order ", n, " (", NrSmallGroups(n), " groups) checked ", total, " pairs\n");
  od;
end;
