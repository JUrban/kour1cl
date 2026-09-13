Read("/project/work/p21_113/brauer_lib.g");
Read("/project/work/p21_113/psi_check.g");
for G in [SymmetricGroup(4), AlternatingGroup(5), SmallGroup(72,41), PSL(2,7), SmallGroup(120,5), MathieuGroup(11)] do
  tbl := CharacterTable(G);
  reps := List(ConjugacyClasses(tbl), Representative);
  for p in PrimeDivisors(Size(G)) do
    psi1 := PsiFromTable(tbl, p);
    psi2 := List(reps, x -> function() if Order(x) mod p = 0 then return 0; else return Number(Centralizer(G,x), y -> IsPElt(y,p)); fi; end());
    Print(StructureDescription(G), " p=", p, " agree=", psi1 = psi2, "\n");
  od;
od;
QUIT;
