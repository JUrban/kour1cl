# C.15 (21.60): G = C3 x| C4 (Dic3), p = 2
G := SmallGroup(12,1);; Print("G = ", StructureDescription(G), "\n");
t := CharacterTable(G);; irr := Irr(t);;
Print("degrees: ", List(irr, c->c[1]), "  Frobenius-Schur indicators: ", Indicator(t, 2), "\n");
Print("Schur indices over Q (via character field and indicator): fields ", List(irr, c -> Field(c)), "\n");
# central primitive idempotents of CG; check 2-integrality of coefficients
cls := ConjugacyClasses(t);; 
for c in irr do
  coeffs := List([1..NrConjugacyClasses(t)], i -> c[1]*ComplexConjugate(c[i])/Size(G));;
  Print("chi(1)=",c[1]," idempotent class coefficients: ", coeffs, "  all in Z_(2): ", ForAll(coeffs, x -> IsRat(x) and DenominatorRat(x) mod 2 = 1) , "\n");
od;
m := t mod 2;; Print("2-modular Brauer degrees: ", List(Irr(m), c->c[1]), "\n");
Print("decomposition matrix mod 2:\n"); Display(DecompositionMatrix(m));
# rational idempotent for the faithful quaternionic character: sum over its (single) Galois orbit
A := GroupRing(GF(2), G);; J := RadicalOfAlgebra(A);;
Print("dim F2G = ", Dimension(A), "  dim J(F2G) = ", Dimension(J), "\n");
QUIT;
