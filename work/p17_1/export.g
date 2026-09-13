Export := function(n, k, out)
  local G, elts, ccs, S, line;
  G := SmallGroup(n, k[1]);
  elts := Elements(G);
  ccs := List(ConjugacyClassesSubgroups(G), Representative);
  for S in Concatenation(List(Filtered(ccs, S -> Size(S) = k[2]), S -> AsList(ConjugacyClassSubgroups(G, S)))) do
    line := Concatenation(String(IsAbelian(S)), " ", JoinStringsWithSeparator(List(Elements(S), x -> String(Position(elts, x))), ","));
    WriteLine(out, line);
  od;
end;
for id in [1..NrSmallGroups(729)] do
  G := SmallGroup(729, id);
  if Exponent(G) <> 3 or IsAbelian(G) then continue; fi;
  Print("exponent-3 group ", [729,id], " ", StructureDescription(G), "\n");
  out := OutputTextFile(Concatenation("/project/work/p17_1/subs_729_", String(id), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  Export(729, [id, 27], out);
  CloseStream(out);
od;
Print("FINISHED\n"); QUIT;
