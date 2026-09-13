# 19.12: export class-product incidence for simple groups (library tables): M[i][j] = list of k with structure constant (i,j,k) > 0
names := AllCharacterTableNames(IsSimple, true, IsDuplicateTable, false, Size, [60..3000000]);
for nm in names do
  tbl := CharacterTable(nm); n := NrConjugacyClasses(tbl);
  if n > 24 then continue; fi;
  out := OutputTextFile(Concatenation("/project/work/p19_12/cp_", ReplacedString(ReplacedString(nm,"(","_"),")","_"), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  WriteLine(out, Concatenation(nm, " ", String(n)));
  for i in [1..n] do for j in [1..n] do
    ks := Filtered([1..n], k -> ClassMultiplicationCoefficient(tbl, i, j, k) > 0);
    WriteLine(out, Concatenation(String(i), " ", String(j), " ", JoinStringsWithSeparator(List(ks, String), ",")));
  od; od;
  CloseStream(out);
  Print("exported ", nm, " (", n, " classes)\n");
od;
Print("FINISHED\n"); QUIT;
