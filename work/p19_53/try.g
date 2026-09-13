# 19.53 (Mazurov): G = <x,y,z | x^3, y^2, z^2, (xy)^3, (yz)^3, g^12 = 1 for all g>. Is |G| <= 12?
# Strategy: add 12th-power relators for finitely many words; if the resulting fp group has order <= 12, done.
F := FreeGroup("x","y","z"); x := F.1; y := F.2; z := F.3;
base := [x^3, y^2, z^2, (x*y)^3, (y*z)^3];
words := [x*z, x*y*z, x^-1*z, x*z*x*z^-1, x*y*x*z, x*z*y, x^-1*y*z, x*z*x^-1*z, (x*z)^2*y, x*y*z*x*z, x*z*x*y*z, x*y*x^-1*z, x^-1*z*x*z, x*z*x^-1*y*z, x*y*z*x^-1*z, x*z*x*y*x*z];
rels := ShallowCopy(base);
for w in words do
  Add(rels, w^12);
  G := F / rels;
  Print("after adding ", Length(rels) - 5, " power relators: ");
  t := CosetTableFromGensAndRels(FreeGeneratorsOfFpGroup(G), RelatorsOfFpGroup(G), [] : max := 3000000, silent := true);
  if t = fail then Print("enumeration failed (>3M)\n"); else Print("order ", Length(t[1]), " abelian invariants ", AbelianInvariants(G), "\n"); fi;
od;
QUIT;
