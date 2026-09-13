Export := function(G, k, out)
  local elts, ccs, S, line;
  elts := Elements(G);
  ccs := List(ConjugacyClassesSubgroups(G), Representative);
  for S in Concatenation(List(Filtered(ccs, S -> Size(S) = k), S -> AsList(ConjugacyClassSubgroups(G, S)))) do
    line := Concatenation(String(IsAbelian(S)), " ", JoinStringsWithSeparator(List(Elements(S), x -> String(Position(elts, x))), ","));
    WriteLine(out, line);
  od;
end;
for id in [1..NrSmallGroups(15625)] do
  G := SmallGroup(15625, id);
  if Exponent(G) <> 5 or IsAbelian(G) then continue; fi;
  Print("exponent-5 group ", [15625,id], " ", StructureDescription(G), "\n");
  out := OutputTextFile(Concatenation("/project/work/p17_1/subs5_", String(id), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  Export(G, 125, out);
  CloseStream(out);
od;
Print("FINISHED\n"); QUIT;
