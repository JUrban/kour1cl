Read("/project/work/p21_113/brauer_check.g");
for G in [SymmetricGroup(3), SymmetricGroup(4), AlternatingGroup(5), SymmetricGroup(5), PSL(2,7), SmallGroup(48,28), SmallGroup(72,41), AlternatingGroup(6), PSL(2,11), MathieuGroup(11), SmallGroup(120,5), PSL(2,13), SymmetricGroup(6), PSL(3,3), PSU(3,3), AlternatingGroup(7)] do
  tbl := CharacterTable(G);
  for p in PrimeDivisors(Size(G)) do
    r := CoeffsB(tbl, p);
    Print(StructureDescription(G), " p=", p, " a_phi=", r, "\n");
  od;
od;
QUIT;
