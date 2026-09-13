# export multiplication table of a group and subgroup index lists
ExportGroup := function(G, fname, subs)
  local els, n, out, i, j, pos, S, e;
  els := Elements(G); n := Length(els);
  out := OutputTextFile(fname, false); SetPrintFormattingStatus(out, false);
  WriteLine(out, String(n));
  for i in [1..n] do
    WriteLine(out, JoinStringsWithSeparator(List([1..n], j -> String(Position(els, els[i]*els[j]) - 1)), " "));
  od;
  WriteLine(out, String(Length(subs)));
  for S in subs do
    WriteLine(out, JoinStringsWithSeparator(List(Elements(S), e -> String(Position(els, e) - 1)), " "));
  od;
  CloseStream(out);
end;
G := PSL(2,8);
subs := List([2,3,4,6,7,8,9,14,18,56], o -> First(List(ConjugacyClassesSubgroups(G), Representative), S -> Size(S) = o));
Print(List(subs, S -> [Size(S), StructureDescription(S)]), "\n");
ExportGroup(G, "/project/work/p20_37/L28.txt", subs);
QUIT;
