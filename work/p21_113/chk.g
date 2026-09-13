Read("/project/work/p21_113/brauer_lib.g");
tbl := CharacterTable("A5"); m := tbl mod 5;
Print(List(Irr(m), x -> x[1]), "\n");
psi := PsiFromTable(tbl, 5); Print(psi, "\n");
fus := GetFusionMap(m, tbl); psim := psi{fus};
Print(List(Irr(m), phi -> ScalarProduct(m, psim, phi)), "\n");
Print(List(Irr(tbl), chi -> ScalarProduct(tbl, psi, chi)), "\n");
QUIT;
