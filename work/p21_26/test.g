Read("/project/work/p21_26/check.g");
for G in [SymmetricGroup(3), SymmetricGroup(4), AlternatingGroup(5), SmallGroup(48,3), SymmetricGroup(5), PSL(2,7)] do
  Print(StructureDescription(G), " ", Check2126(G), "\n");
od;
QUIT;
