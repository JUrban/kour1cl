G := DihedralGroup(IsPermGroup, 10);;
ct := CharacterTable(G);; irr := Irr(ct);; cls := ConjugacyClasses(ct);;
A := AutomorphismGroup(G);;
Print("degrees: ", List(irr, c->c[1]), "  T(G) = ", Sum(List(irr,c->c[1])), "  |Aut| = ", Size(A), "\n");
for aut in List(ConjugacyClasses(A), Representative) do
  iota := List(irr, chi -> Sum(G, g -> chi[PositionProperty(cls, c -> g*Image(aut,g) in c)])/Size(G));
  inv := Number(G, g -> Image(aut,g) = g^-1);
  Print("aut order ", Order(aut), ": iota = ", iota, "  |iota|^2 = ", List(iota, x -> x*ComplexConjugate(x)),
        "  inverted = ", inv, "  sum chi(1) iota = ", Sum([1..Length(irr)], i -> irr[i][1]*iota[i]), "\n");
od;
QUIT;
