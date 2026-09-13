# 13.19 targeted search: G = G1 x G2 x G3 with Gi = P (nonabelian 2-group); Q <= G subdirect; H normal in Q subdirect; Q/H nonabelian 2-group.
Search1319 := function(P, name)
  local G, proj, subs, Q, nsQ, H, Pq, cnt, i, ok;
  G := DirectProduct(P, P, P);
  proj := List([1..3], i -> Projection(G, i));
  subs := List(ConjugacyClassesSubgroups(G), Representative);
  cnt := 0;
  for Q in subs do
    if not ForAll(proj, f -> Size(Image(f, Q)) = Size(P)) then continue; fi;
    if Size(Q) < 8 * Size(P) then continue; fi;
    nsQ := NormalSubgroups(Q);
    for H in nsQ do
      if not IsPrimePowerInt(Index(Q, H)) or Index(Q, H) < 8 then continue; fi;
      if not ForAll(proj, f -> Size(Image(f, H)) = Size(P)) then continue; fi;
      Pq := Q / H;
      if not IsAbelian(Pq) then
        cnt := cnt + 1;
        Print("COUNTEREXAMPLE: ", name, "^3, Q of order ", Size(Q), " H of order ", Size(H), " Q/H = ", StructureDescription(Pq), "\n");
      fi;
    od;
  od;
  Print("done ", name, "^3: subdirect Q's checked, counterexamples: ", cnt, "\n");
end;
Search1319(DihedralGroup(8), "D8");
Search1319(QuaternionGroup(8), "Q8");
Search1319(SmallGroup(16,3), "16_3");
Search1319(SmallGroup(16,4), "16_4");
Search1319(DihedralGroup(16), "D16");
Search1319(SmallGroup(16,6), "M16");
Print("FINISHED\n"); QUIT;
