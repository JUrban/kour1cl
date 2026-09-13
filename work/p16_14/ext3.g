Read("/project/work/p16_14/ext.g");
# General version: hypothetical minimal counterexample G with rank(Omega_1(G)) = r, d(G) = 2r+1, H = G/E.
# (F1) H has no elementary abelian subgroup of rank 2r+1 (Chevalley-Warning);
# (F2) every maximal subgroup M of H has Phi(M) = Phi(H);
# (F3) no involution of H lifts to an involution in every central extension by GF(2) (zero functional).
HasElAbOfOrder := function(H, ord)
  local M;
  if Size(H) < ord then return false; fi;
  if Size(H) = ord then return IsElementaryAbelian(H); fi;
  if IsElementaryAbelian(H) then return true; fi;
  return ForAny(MaximalSubgroups(H), M -> HasElAbOfOrder(M, ord));
end;
AnalyseR := function(n, k, r, tag)
  local H, PhiH, f2, cd, W, rowsS, out, row, nz;
  H := SmallGroup(n, k);
  if RankPGroup(H) <> 2*r+1 then return "rank"; fi;
  PhiH := FrattiniSubgroup(H);
  if HasElAbOfOrder(H, 2^(2*r+1)) then Print(tag, " ", [n,k], " F1: 2-rank >= ", 2*r+1, " -> excluded\n"); return "F1"; fi;
  f2 := ForAll(MaximalSubgroups(H), M -> FrattiniSubgroup(M) = PhiH);
  if not f2 then Print(tag, " ", [n,k], " F2: some maximal subgroup has smaller Frattini -> excluded\n"); return "F2"; fi;
  cd := CocycleData(H);
  nz := Number(cd.rows, x -> IsZero(x));
  if nz > 0 then Print(tag, " ", [n,k], " F3: ", nz, " involutions always lift to involutions -> excluded\n"); return "F3"; fi;
  W := VectorSpace(GF(2), cd.rows);
  rowsS := Set(cd.rows);
  Print(tag, " ", [n,k], " SURVIVOR: #inv=", Length(cd.inv), " dimZ2=", cd.m, " dimH2=", cd.dimH2, " dim span=", Dimension(W), " distinct=", Length(rowsS), "\n");
  out := OutputTextFile(Concatenation("/project/work/p16_14/L_", String(n), "_", String(k), ".txt"), false);
  SetPrintFormattingStatus(out, false);
  WriteLine(out, Concatenation(String(Length(rowsS)), " ", String(cd.m)));
  for row in rowsS do WriteLine(out, Concatenation(List(row, x -> String(IntFFE(x))))); od;
  CloseStream(out);
  return "S";
end;
