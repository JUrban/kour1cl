# Direct power-commutator presentation for the 13.19 example (fast verification).
F := FreeGroup(9); g := GeneratorsOfGroup(F);
# g1=e1, g2=f1, g3=e2, g4=f2, g5=e3, g6=f3, g7=u12, g8=u13, g9=u23
e := [g[1],g[3],g[5]]; f := [g[2],g[4],g[6]]; u12 := g[7]; u13 := g[8]; u23 := g[9];
w := [[u12,u12,u13],[u12,u23,u23],[u13,u23,u13]];
rels := List(g, x -> x^2);
comm := function(a, b) return a^-1*b^-1*a*b; end;
# pc relations: for i<j, g_j^g_i = g_j * [g_j, g_i]; we give [g_j,g_i] as words in u's (central)
gens := [e[1],f[1],e[2],f[2],e[3],f[3]];
val := function(a, b)  # [a,b] for a,b in gens
  local ia, ib, i, j, ta, tb;
  ia := Position(gens, a); ib := Position(gens, b);
  i := QuoInt(ia-1, 2)+1; j := QuoInt(ib-1, 2)+1; ta := (ia-1) mod 2; tb := (ib-1) mod 2;   # ta=0 for e, 1 for f
  if ta = tb then return One(F); fi;      # [e_i,e_j] = [f_i,f_j] = 1 (and [e_i,e_i] trivially)
  return w[i][j];                          # [e_i,f_j] = [f_i,e_j] = w_ij (symmetric), w_ii for i=j
end;
for ia in [1..6] do for ib in [ia+1..6] do
  Add(rels, comm(gens[ib], gens[ia]) * val(gens[ib], gens[ia])^-1);
od; od;
for x in [u12,u13,u23] do for y in g do if x <> y then Add(rels, comm(y, x)); fi; od; od;
Q := PcGroupFpGroup(F / rels);
Print("|Q| = ", Size(Q), " class ", NilpotencyClassOfGroup(Q), "\n");
G := GeneratorsOfGroup(Q);
Ev := [G[1],G[3],G[5]]; Fv := [G[2],G[4],G[6]]; U12 := G[7]; U13 := G[8]; U23 := G[9];
# sanity: check the relations hold as intended
Print("relation check [e1,f1]=u12: ", Comm(Ev[1],Fv[1]) = U12, " [e1,f2]=u12: ", Comm(Ev[1],Fv[2]) = U12, " [e2,f3]=u23: ", Comm(Ev[2],Fv[3]) = U23, " [e1,e2]=1: ", IsOne(Comm(Ev[1],Ev[2])), " [e3,f3]=u13: ", Comm(Ev[3],Fv[3]) = U13, "\n");
A := Subgroup(Q, [U12,U13,U23]); A0 := Subgroup(Q, [U12*U13, U13*U23]);
N := [Subgroup(Q, [Ev[1],Fv[1],U12,U13]), Subgroup(Q, [Ev[2],Fv[2],U12,U23]), Subgroup(Q, [Ev[3],Fv[3],U13,U23])];
Print("|N_i| = ", List(N, Size), " normal: ", List(N, S -> IsNormal(Q,S)), " |N1 meet N2 meet N3| = ", Size(Intersection(N)), " pairwise: ", List([[1,2],[1,3],[2,3]], p -> Size(Intersection(N[p[1]],N[p[2]]))), "\n");
Hhat := ClosureGroup(A, [Ev[1]*Ev[2], Ev[2]*Ev[3], Fv[1]*Fv[2], Fv[2]*Fv[3]]);
Print("|Hhat| = ", Size(Hhat), " Hhat/A0 elem. abelian: ", IsElementaryAbelian(Hhat/A0), " Hhat/A0 central in Q/A0: ", IsCentral(Q/A0, Image(NaturalHomomorphismByNormalSubgroup(Q,A0), Hhat)), "\n");
found := 0;
for H in Filtered(List(ConjugacyClassesSubgroups(Hhat), Representative), S -> Index(Hhat, S) = 2) do
  for Hc in AsList(ConjugacyClassSubgroups(Hhat, H)) do
    if not IsNormal(Q, Hc) or Intersection(Hc, A) <> A0 then continue; fi;
    if not ForAll(N, Ni -> Size(ClosureGroup(Hc, Ni)) = Size(Q)) then continue; fi;
    P := Q / Hc; found := found + 1;
    if found = 1 then
      Print("FOUND H (order ", Size(Hc), "): Q/H = ", StructureDescription(P), ", abelian: ", IsAbelian(P), "\n");
      Print("G_i = Q/N_i: ", List(N, Ni -> StructureDescription(Q/Ni)), "\n");
      Print("H generators: ", List(GeneratorsOfGroup(Hc), x -> ExtRepOfObj(x)), "\n");
    fi;
  od;
od;
Print("number of valid H: ", found, "\nFINISHED\n"); QUIT;
