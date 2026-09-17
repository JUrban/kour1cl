# E.4 (16.60): twisted Frobenius-Schur identity and the bound by T(G) = sum of character degrees
test := function(G)
  local ct, irr, A, aut, iota, inv, T, chi, g, s, ok;
  ct := CharacterTable(G);; irr := Irr(ct);;
  T := Sum(List(irr, c -> c[1]));
  A := AutomorphismGroup(G);;
  ok := true;
  for aut in List(ConjugacyClasses(A), Representative) do
    inv := Number(G, g -> Image(aut,g) = g^-1);
    iota := List(irr, chi -> Sum(G, g -> chi[PositionProperty(ConjugacyClasses(ct), c -> g*Image(aut,g) in c)])/Size(G));
    s := Sum([1..Length(irr)], i -> irr[i][1]*iota[i]);
    if s <> inv then ok := false; Print("  identity FAILS\n"); fi;
    if ForAny(iota, x -> not IsRat(x*ComplexConjugate(x)) or x*ComplexConjugate(x) > 1) then ok := false; Print("  |iota| > 1 !\n"); fi;
    if inv > T then ok := false; Print("  bound FAILS\n"); fi;
  od;
  Print(StructureDescription(G), ": T(G) = ", T, "  max inverted = ",
        Maximum(List(List(ConjugacyClasses(A), Representative), aut -> Number(G, g -> Image(aut,g) = g^-1))),
        "  identity and bound hold: ", ok, "\n");
end;;
for G in [SymmetricGroup(3), QuaternionGroup(IsPermGroup,8), DihedralGroup(IsPermGroup,10), SmallGroup(12,1), AlternatingGroup(4), SmallGroup(16,3), SymmetricGroup(4)] do test(G); od;
QUIT;
