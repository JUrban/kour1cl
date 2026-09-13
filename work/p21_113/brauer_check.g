# 21.113(b): Psi = sum_phi a_phi Phi_phi with a_phi = (1/|G|) sum_g phi(g_{p'}).  Check a_phi >= 0 integer.
CoeffsB := function(tbl, p)
  local modtbl, ibr, cls, ords, n, reg, i, psi, sizes, pcnt, G, reps, C, res, phi, a, fus, cen;
  modtbl := tbl mod p;
  if modtbl = fail then return fail; fi;
  ibr := Irr(modtbl);
  # Psi on p-regular classes of modtbl: number of p-elements in centralizer
  fus := GetFusionMap(modtbl, tbl);
  ords := OrdersClassRepresentatives(tbl);
  sizes := SizesConjugacyClasses(tbl);
  n := Length(ords);
  # number of p-elements in C_G(x): via class multiplication? use power maps: y p-element commuting with x.
  # Simpler: number of p-elements of C(x) = sum over classes D of p-elements of |{y in D : xy=yx}| ; compute via
  # class functions: #{y in D commuting with x} = |D| * (number of classes...) -- use the group directly instead.
  G := UnderlyingGroup(tbl);
  reps := List(ConjugacyClasses(tbl), Representative);
  psi := [];
  for i in [1..Length(fus)] do
    C := Centralizer(G, reps[fus[i]]);
    Add(psi, Number(C, y -> Order(y) = 1 or (IsPrimePowerInt(Order(y)) and Order(y) mod p = 0)));
  od;
  res := [];
  for phi in ibr do
    a := ScalarProduct(modtbl, psi, phi);   # (1/|G|) sum over p-regular classes |cl| psi(x) phi(x^-1)
    Add(res, a);
  od;
  return res;
end;
