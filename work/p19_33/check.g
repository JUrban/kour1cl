# 19.33 (Giannelli): chi in Irr(G), p | chi(1), P Sylow p; if chi_P has a linear constituent then it has >= p linear constituents (counted with multiplicity? "at least p linear constituents").
CheckGroup := function(G, name)
  local tbl, irr, p, P, tP, lin, chi, res, cnt, cntm, l;
  tbl := CharacterTable(G); irr := Irr(tbl);
  for p in PrimeDivisors(Size(G)) do
    P := SylowSubgroup(G, p); tP := CharacterTable(P);
    lin := Filtered(Irr(tP), l -> l[1] = 1);
    for chi in irr do
      if chi[1] mod p <> 0 then continue; fi;
      res := RestrictedClassFunction(chi, tP);
      cnt := Number(lin, l -> ScalarProduct(tP, res, l) > 0);
      cntm := Sum(lin, l -> ScalarProduct(tP, res, l));
      if cnt > 0 and cnt < p then Print("COUNTEREXAMPLE (distinct) ", name, " p=", p, " chi(1)=", chi[1], " distinct linear constituents ", cnt, " with mult ", cntm, "\n"); fi;
    od;
  od;
end;
for n in [60..2000] do
  if NrSmallGroups(n) > 5000 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsSolvable(G) then continue; fi;
    CheckGroup(G, [n,k]);
  od;
od;
Print("small nonsolvable done\n");
for G in SimpleGroupsIterator(60, 1000000) do CheckGroup(G, Name(G)); od;
Print("FINISHED\n"); QUIT;
