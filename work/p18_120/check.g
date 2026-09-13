# 18.120 (Jabara): P = AB p-group, A abelian, B of class 2 (A meet B = 1 optionally). Is <A, B'> = A B_0 with B_0 abelian <= B?
CheckGroup := function(P, id)
  local ccs, subs, A, B, C, ok, B0, absB, n;
  n := Size(P);
  subs := Concatenation(List(ConjugacyClassesSubgroups(P), c -> AsList(c)));
  for A in Filtered(subs, IsAbelian) do
    for B in Filtered(subs, S -> NilpotencyClassOfGroup(S) = 2) do
      if Size(A) * Size(B) / Size(Intersection(A, B)) <> n then continue; fi;   # then P = AB
      C := ClosureGroup(A, DerivedSubgroup(B));
      absB := Filtered(List(ConjugacyClassesSubgroups(B), Representative), IsAbelian);
      ok := ForAny(absB, B0r -> ForAny(AsList(ConjugacyClassSubgroups(B, B0r)), B0 -> Size(A)*Size(B0)/Size(Intersection(A,B0)) = Size(C) and IsSubgroup(C, B0)));
      if not ok then Print("COUNTEREXAMPLE: SmallGroup(", id, ") ", StructureDescription(P), " |A|=", Size(A), " |B|=", Size(B), " A meet B trivial: ", Size(Intersection(A,B)) = 1, "\n"); fi;
    od;
  od;
end;
for n in [8, 16, 32, 64, 27, 81, 243, 125] do
  for k in [1..NrSmallGroups(n)] do
    P := SmallGroup(n,k); if IsAbelian(P) then continue; fi;
    CheckGroup(P, [n,k]);
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
