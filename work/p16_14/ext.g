# 16.14: search for a counterexample of order 2^11.
# Theory (see report): such G has E = Omega_1(G) of rank 3, d(G) = 7, Phi(G) of order 16 > E, so H := G/E has
# order 256, d(H) = 7, |Phi(H)| = 2, and G is a central extension of H by E = C2^3 with
#   (i) E <= Phi(G)  (the three cohomology classes are linearly independent mod coboundaries),
#   (ii) no involution outside E: for every involution h of H, the lift squares to a non-trivial element of E.
# For a 2-cocycle c (values in GF(2)) and involution h, let l_h(c) in GF(2) be the square of the lift of h in the
# extension by c. Then l_h is linear in c and vanishes on coboundaries. Condition (ii) for classes (a1,a2,a3):
# for every involution h, (l_h(a1), l_h(a2), l_h(a3)) <> 0.
LoadPackage("polycyclic");;
Involutions := function(H) return Filtered(Elements(H), h -> Order(h) = 2); end;
# compute the matrix of functionals l_h on a basis of the cocycle space
CocycleData := function(H)
  local M, coh, Z, B, basisZ, n, exts, inv, rows, c, Ext, gensE, m, lifts, h, sq, i, k, row, ngens, e;
  M := GModuleByMats([List(GeneratorsOfGroup(H), g -> IdentityMat(1, GF(2)))][1], GF(2));
  Z := VectorSpace(GF(2), TwoCocycles(H, M));
  B := VectorSpace(GF(2), TwoCoboundaries(H, M), Zero(Z));
  coh := fail;
  inv := Involutions(H);
  ngens := Length(Pcgs(H));
  rows := [];   # rows[i] = l_{inv[i]} as a vector over the cocycle basis
  basisZ := BasisVectors(Basis(Z));
  m := Length(basisZ);
  for i in [1..Length(inv)] do rows[i] := ListWithIdenticalEntries(m, Zero(GF(2))); od;
  for k in [1..m] do
    c := basisZ[k];
    Ext := Extension(H, M, c);
    e := ExponentsOfPcElement(Pcgs(H), One(H));
    for i in [1..Length(inv)] do
      h := inv[i];
      # lift: pc element of Ext with the same exponents on the first ngens generators
      sq := PcElementByExponents(Pcgs(Ext), Concatenation(ExponentsOfPcElement(Pcgs(H), h), [0]))^2;
      if sq <> One(Ext) then rows[i][k] := One(GF(2)); fi;
    od;
  od;
  return rec(coh := coh, Z := Z, B := B, basisZ := basisZ, inv := inv, rows := rows, m := m,
             dimH2 := Dimension(Z) - Dimension(B));
end;
