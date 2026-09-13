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
