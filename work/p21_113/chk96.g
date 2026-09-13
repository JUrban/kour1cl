Read("/project/work/p21_113/brauer_lib.g");
for id in [[96,64],[96,227]] do
  G := SmallGroup(id); tbl := CharacterTable(G); p := 3;
  psi := PsiFromTable(tbl, p);
  Print(id, " ", StructureDescription(G), " psi=", psi, "\n");
  Print("  ordinary mults: ", List(Irr(tbl), chi -> ScalarProduct(tbl, psi, chi)), "\n");
  m := tbl mod p;
  if m <> fail then
    fus := GetFusionMap(m, tbl); psim := psi{fus};
    Print("  IBr degrees: ", List(Irr(m), x->x[1]), "\n");
    Print("  a_phi: ", List(Irr(m), phi -> ScalarProduct(m, psim, phi)), "\n");
  else Print("  no Brauer table\n"); fi;
od;
QUIT;
