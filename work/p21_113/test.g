Read("/project/work/p21_113/psi_check.g");
for G in [SymmetricGroup(3), SymmetricGroup(4), AlternatingGroup(5), SymmetricGroup(5), SL(2,5), PSL(2,7), SmallGroup(96,3)] do
  for p in PrimeDivisors(Size(G)) do
    Print(StructureDescription(G), " p=", p, " bad=", PsiCheck(G,p), "\n");
  od;
od;
QUIT;
