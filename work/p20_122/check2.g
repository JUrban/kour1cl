# 20.122 (Zenkov) -- proper version: A, B, C range over ALL nilpotent subgroups (up to conjugacy) not contained in F(G).
Read("/project/work/p20_122/check.g_functions");
CheckGroup2 := function(G, name)
  local F, nil, i, j, k, A, B, C, r, cnt;
  F := FittingSubgroup(G);
  nil := Filtered(List(ConjugacyClassesSubgroups(G), Representative), N -> Size(N) > 1 and IsNilpotent(N) and not IsSubgroup(F, N));
  cnt := 0;
  for i in [1..Length(nil)] do for j in [i..Length(nil)] do for k in [j..Length(nil)] do
    A := nil[i]; B := nil[j]; C := nil[k]; cnt := cnt + 1;
    r := MinData(G, A, B, C);
    if not r.minOK then Print("COUNTEREXAMPLE(a) ", name, " soluble=", IsSolvableGroup(G), " ", StructureDescription(G), " A=", StructureDescription(A), " B=", StructureDescription(B), " C=", StructureDescription(C), " minord=", r.minord, " sizes of Min: ", r.sizes, "\n"); fi;
    if not r.MinOK then Print("COUNTEREXAMPLE(b) ", name, " soluble=", IsSolvableGroup(G), " ", StructureDescription(G), " A=", StructureDescription(A), " B=", StructureDescription(B), " C=", StructureDescription(C), " minord=", r.minord, " sizes of Min: ", r.sizes, "\n"); fi;
  od; od; od;
  return cnt;
end;
for n in [6..200] do
  if Length(PrimeDivisors(n)) < 2 then continue; fi;
  tot := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsNilpotent(G) then continue; fi;
    tot := tot + CheckGroup2(G, Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
  od;
  Print("done order ", n, " triples checked ", tot, "\n");
od;
Print("FINISHED\n"); QUIT;
