BreakOnError := false;
# 18.44 (Keller): G nonabelian, V faithful irreducible G-module, M = |G/G'| = largest orbit size, exactly two orbits of size M => G = D8, |V| = 9 ?
CheckGroup := function(G, id)
  local q, M, reps, r, img, d, V, orbs, lens, mx, cnt;
  M := Index(G, DerivedSubgroup(G));
  for q in [2,3,4,5,7,8,9,11,13] do
    reps := CALL_WITH_CATCH(IrreducibleRepresentations, [G, GF(q)]);
    if not reps[1] then continue; fi;
    reps := reps[2];
    for r in reps do
      d := DimensionOfMatrixGroup(Image(r));
      if q^d > 200000 or q^d = q then continue; fi;   # skip 1-dim (nonfaithful for nonabelian) and huge
      if Size(Image(r)) <> Size(G) then continue; fi;   # faithful
      V := GF(q)^d;
      orbs := OrbitLengths(Image(r), Elements(V), OnRight);
      mx := Maximum(orbs);
      if mx = M then
        cnt := Number(orbs, x -> x = M);
        if cnt = 2 then Print("HIT ", id, " ", StructureDescription(G), " q=", q, " d=", d, " |V|=", q^d, " |G/G'|=", M, "\n"); fi;
      fi;
    od;
  od;
end;
for n in [6..200] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    CheckGroup(G, [n,k]);
  od;
  if n mod 10 = 0 then Print("done order ", n, "\n"); fi;
od;
Print("FINISHED\n"); QUIT;
