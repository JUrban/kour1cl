Read("/project/work/p16_14/ext.g");
ids := Filtered([1..NrSmallGroups(256)], k -> RankPGroup(SmallGroup(256,k)) = 7);
Print("groups of order 256 with d = 7: ", ids, "\n");
for k in ids do
  H := SmallGroup(256, k);
  Print("H = SmallGroup(256,", k, ") ", StructureDescription(H), " #inv = ", Number(Elements(H), h -> Order(h)=2), "\n");
  cd := CocycleData(H);
  W := VectorSpace(GF(2), cd.rows);
  Print("  dim Z2 = ", cd.m, " dim H2 = ", cd.dimH2, " dim span(l_h) = ", Dimension(W),
        " zero functionals: ", Number(cd.rows, r -> IsZero(r)), " distinct: ", Length(Set(cd.rows)), "\n");
  # check the coboundaries are killed
  Print("  l_h vanish on coboundaries: ", ForAll(BasisVectors(Basis(cd.B)), b -> ForAll(cd.rows, r -> IsZero(r*b))), "\n");
  # export the distinct nonzero functionals as bit rows for the C solver
  rowsS := Set(cd.rows);
  out := OutputTextFile(Concatenation("/project/work/p16_14/L_256_", String(k), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  WriteLine(out, Concatenation(String(Length(rowsS)), " ", String(cd.m)));
  for r in rowsS do WriteLine(out, Concatenation(List(r, x -> String(IntFFE(x))))); od;
  CloseStream(out);
od;
QUIT;
