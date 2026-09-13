# For each small group G and prime p: export Psi and the induced trivial characters 1_H^G for p'-subgroups H (up to conjugacy)
Read("/project/work/p21_113/brauer_lib.g");
ExportLP := function(G, p, out)
  local tbl, psi, ccs, Hs, chars, H, ind, line;
  tbl := CharacterTable(G);
  psi := PsiFromTable(tbl, p);
  ccs := List(ConjugacyClassesSubgroups(G), Representative);
  Hs := Filtered(ccs, H -> Size(H) mod p <> 0);
  chars := List(Hs, H -> ValuesOfClassFunction(InducedClassFunction(TrivialCharacter(H), tbl)));
  AppendTo(out, "{\"group\": \"", IdGroup(G), "\", \"p\": ", p, ", \"psi\": ", psi, ", \"perm\": ", chars, "}\n");
end;
