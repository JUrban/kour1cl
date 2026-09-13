Read("/project/work/p21_113/brauer_lib.g");
CheckB := function(lo, hi)
  local n, k, G, tbl, p, psi, m, fus, psim, a, cnt;
  cnt := 0;
  for n in [lo..hi] do
    if Length(PrimeDivisors(n)) < 2 then continue; fi;
    for k in [1..NrSmallGroups(n)] do
      G := SmallGroup(n, k);
      if IsNilpotent(G) then continue; fi;
      tbl := CharacterTable(G);
      for p in PrimeDivisors(n) do
        if not IsPSolvable(G, p) then continue; fi;
        psi := PsiFromTable(tbl, p);
        m := tbl mod p;
        if m = fail then Print("no Brauer table for ", [n,k], " p=", p, "\n"); continue; fi;
        fus := GetFusionMap(m, tbl); psim := psi{fus};
        a := List(Irr(m), phi -> ScalarProduct(m, psim, phi));
        cnt := cnt + 1;
        if not ForAll(a, x -> IsInt(x) and x >= 0) then
          Print("(b) FAILS: SmallGroup(", n, ",", k, ") p=", p, " a=", a, "\n");
        fi;
      od;
    od;
    Print("done order ", n, " checked ", cnt, "\n");
  od;
  Print("FINISHED ", lo, "..", hi, "\n");
end;
