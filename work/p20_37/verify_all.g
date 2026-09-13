Read("/project/work/p20_37/verify.g");
files := Filtered(DirectoryContents("/project/work/p20_37"), f -> StartsWith(f, "sol_"));
Sort(files, function(a,b) return Int(a{[5..Length(a)-4]}) < Int(b{[5..Length(b)-4]}); end);
for f in files do
  n := Int(f{[5..Length(f)-4]});
  lines := Filtered(SplitString(StringFile(Concatenation("/project/work/p20_37/case_", String(n), ".txt")), "\n"), l -> l <> "");
  ng := Int(lines[3]);
  gens := List([4..3+ng], i -> PermList(List(SplitString(lines[i], " "), Int) + 1));
  G := Group(gens);
  Print("|G| = ", Size(G), " (", StructureDescription(G), "): ");
  if Size(G) <> n then Print("ORDER MISMATCH\n"); continue; fi;
  Print("\n");
  VerifySol(G, Concatenation("/project/work/p20_37/", f));
od;
Print("FINISHED\n"); QUIT;
