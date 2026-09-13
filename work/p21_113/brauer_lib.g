# 21.113(b) via library character tables (ordinary + Brauer).
# Psi(x) for p-regular x = number of p-elements in C_G(x) = sum over classes D of p-elements of |D meet C(x)|,
# |D meet C(x)| = (|D|/|G|) sum_chi |chi(x)|^2 |chi(y)|^2 / chi(1)^2  (Frobenius count of commuting pairs / |C_x|).
PsiFromTable := function(tbl, p)
  # Psi(x) = #{g in G : g_{p'} = x} = sum over classes E with (E)_{p'} = class(x) of |E|/|class(x)|.
  local ords, sizes, n, psi, E, o, op, k, target;
  ords := OrdersClassRepresentatives(tbl); sizes := SizesConjugacyClasses(tbl);
  n := Length(ords);
  psi := ListWithIdenticalEntries(n, 0);
  for E in [1..n] do
    o := ords[E];
    op := p^PValuation(o, p);
    k := ChineseRem([op, o/op], [0, 1]);
    target := PowerMap(tbl, k)[E];
    psi[target] := psi[target] + sizes[E] / sizes[target];
  od;
  return psi;
end;
CheckTable := function(name)
  local tbl, p, modtbl, psi, fus, psim, res, chi, bad, phi, a, allok;
  tbl := CharacterTable(name);
  if tbl = fail then return; fi;
  allok := true;
  for p in PrimeDivisors(Size(tbl)) do
    psi := PsiFromTable(tbl, p);
    if not ForAll(psi, IsInt) then Print(name, " p=", p, " NON-INTEGRAL PSI?? ", psi, "\n"); fi;
    # (a): ordinary multiplicities
    bad := Filtered(List(Irr(tbl), chi -> ScalarProduct(tbl, psi, chi)), a -> not (IsInt(a) and a >= 0));
    if Length(bad) > 0 then Print("(a) FAILS: ", name, " p=", p, " ", bad, "\n"); allok := false; fi;
    modtbl := tbl mod p;
    if modtbl = fail then continue; fi;
    fus := GetFusionMap(modtbl, tbl);
    psim := psi{fus};
    bad := Filtered(List(Irr(modtbl), phi -> ScalarProduct(modtbl, psim, phi)), a -> not (IsInt(a) and a >= 0));
    if Length(bad) > 0 then Print("(b) FAILS: ", name, " p=", p, " ", bad, "\n"); allok := false; fi;
  od;
  if allok then Print("ok ", name, " |G|=", Size(tbl), "\n"); fi;
end;
