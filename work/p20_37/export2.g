# Export: for each simple group with chain-missing factor sizes, the permutation generators of G and generators of
# subgroup class representatives whose orders divide some missing a (a <= |G|/a).
Read("/project/work/p20_37/chain.g");
PermList0 := p -> List([1..LargestMovedPoint(p)], i -> i^p - 1);
ExportCase := function(S, fname)
  local G, miss, orders, cls, out, H, gens, d, mset;
  G := S; if not IsPermGroup(G) then G := Image(IsomorphismPermGroup(G)); fi;
  G := Image(SmallerDegreePermutationRepresentation(G));
  miss := Missing(G);
  if Length(miss) = 0 then return false; fi;
  mset := Set(List(miss, a -> Minimum(a, Size(G)/a)));
  d := NrMovedPoints(G);
  out := OutputTextFile(fname, false); SetPrintFormattingStatus(out, false);
  WriteLine(out, Concatenation(String(Size(G)), " ", String(LargestMovedPoint(G))));
  WriteLine(out, JoinStringsWithSeparator(mset, " "));
  WriteLine(out, String(Length(GeneratorsOfGroup(G))));
  for gens in GeneratorsOfGroup(G) do WriteLine(out, JoinStringsWithSeparator(PermList0(gens), " ")); od;
  cls := Filtered(List(ConjugacyClassesSubgroups(G), Representative), H -> Size(H) > 1 and Size(H) < Size(G) and ForAny(mset, a -> a mod Size(H) = 0 or (Size(G)/a) mod Size(H) = 0));
  WriteLine(out, String(Length(cls)));
  for H in cls do
    WriteLine(out, Concatenation(String(Size(H)), " ", String(Length(GeneratorsOfGroup(H)))));
    for gens in GeneratorsOfGroup(H) do WriteLine(out, JoinStringsWithSeparator(PermList0(gens), " ")); od;
  od;
  CloseStream(out);
  Print(StructureDescription(S), " |G|=", Size(G), " degree ", LargestMovedPoint(G), " missing (a<=b): ", mset, " subgroups exported: ", Length(cls), "\n");
  return true;
end;
