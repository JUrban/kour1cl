Read("/project/work/p16_14/ext.g");
# For a candidate quotient H = G/E of a hypothetical counterexample G (|G| = 8|H|, d(G) = 7, rank E = 3):
# filters: (F1) 2-rank(H) <= 6 [Chevalley-Warning]; (F2) every maximal subgroup M of H has Phi(M) = Phi(H);
# (F3) no involution h of H with l_h = 0.  Survivors: export the functionals for the C search.
# does H contain an elementary abelian subgroup of order >= 128 (rank >= 7)?  Walk down maximal subgroups.
HasElAbOfOrder := function(H, ord)
  local M;
  if Size(H) < ord then return false; fi;
  if Size(H) = ord then return IsElementaryAbelian(H); fi;
  if IsElementaryAbelian(H) then return true; fi;
  return ForAny(MaximalSubgroups(H), M -> HasElAbOfOrder(M, ord));
end;
TwoRankAtLeast7 := function(H) return HasElAbOfOrder(H, 128); end;
Analyse := function(n, k, tag)
  local H, PhiH, f2, cd, W, rowsS, out, r, nz;
  H := SmallGroup(n, k);
  PhiH := FrattiniSubgroup(H);
  if TwoRankAtLeast7(H) then Print(tag, " ", [n,k], " F1: 2-rank >= 7 -> excluded\n"); return "F1"; fi;
  f2 := ForAll(MaximalSubgroups(H), M -> FrattiniSubgroup(M) = PhiH);
  if not f2 then Print(tag, " ", [n,k], " F2: some maximal subgroup has smaller Frattini -> excluded\n"); return "F2"; fi;
  cd := CocycleData(H);
  nz := Number(cd.rows, r -> IsZero(r));
  if nz > 0 then Print(tag, " ", [n,k], " F3: ", nz, " involutions always lift to involutions -> excluded\n"); return "F3"; fi;
  W := VectorSpace(GF(2), cd.rows);
  rowsS := Set(cd.rows);
  Print(tag, " ", [n,k], " SURVIVOR: #inv=", Length(cd.inv), " dimZ2=", cd.m, " dimH2=", cd.dimH2, " dim span=", Dimension(W), " distinct=", Length(rowsS), "\n");
  out := OutputTextFile(Concatenation("/project/work/p16_14/L_", String(n), "_", String(k), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  WriteLine(out, Concatenation(String(Length(rowsS)), " ", String(cd.m)));
  for r in rowsS do WriteLine(out, Concatenation(List(r, x -> String(IntFFE(x))))); od;
  CloseStream(out);
  return "S";
end;
