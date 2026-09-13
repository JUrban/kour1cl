Read("/project/work/p21_26/check2.g");
for G in [SymmetricGroup(3), SymmetricGroup(4), AlternatingGroup(5), SmallGroup(48,3), SymmetricGroup(5), PSL(2,7), SymmetricGroup(6), PSL(2,11), SmallGroup(96,3), SmallGroup(192,955), SmallGroup(576,8654), SymmetricGroup(7)] do
  r := Check2126b(G, 200);
  Print(StructureDescription(G), " ", Size(G), " -> ", r[1], " ", r[3], "\n");
od;
QUIT;
