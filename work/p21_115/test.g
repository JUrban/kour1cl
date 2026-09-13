Read("/project/work/p21_115/check.g");
for G in [CyclicGroup(8), CyclicGroup(12), SymmetricGroup(3), SymmetricGroup(4), SmallGroup(16,3), DihedralGroup(16)] do
  Print(StructureDescription(G), " ", Length(SearchGroup(G, 4)), "\n");
od;
QUIT;
