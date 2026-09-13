# Explicit construction for 13.19: Q of order 512 (class 2), normal N1,N2,N3 with trivial intersection,
# H normal with H N_i = Q for all i, Q/H nonabelian of order 8 (hence an irregular 2-group).
F := GF(2); z := Zero(F); o := One(F);
# elements: (x, a) with x in F^6 (three blocks of F^2), a in F^3 (basis u12,u13,u23)
gam := function(v, w) return v[1]*w[2] + v[2]*w[1]; end;   # alternating form on F^2
c1  := function(v, w) return v[1]*w[2]; end;                # c1(v,v) = v1 v2 = q1 (hyperbolic), c1+c1^T = gam
w := [[[o,z,z],[o,z,z],[z,o,z]],      # w[1][1]=u12, w[1][2]=u12, w[1][3]=u13
      [[o,z,z],[z,z,o],[z,z,o]],      # w[2][1]=u12, w[2][2]=u23, w[2][3]=u23
      [[z,o,z],[z,z,o],[z,o,z]]];     # w[3][1]=u13, w[3][2]=u23, w[3][3]=u13
blk := function(x, i) return x{[2*i-1, 2*i]}; end;
coc := function(x, y) local a, i, j;
  a := [z,z,z];
  for i in [1..3] do a := a + c1(blk(x,i), blk(y,i)) * w[i][i]; od;
  for i in [1..3] do for j in [i+1..3] do a := a + gam(blk(x,i), blk(y,j)) * w[i][j]; od; od;
  return a; end;
vecs6 := Elements(F^6); vecs3 := Elements(F^3);
elts := Concatenation(List(vecs6, x -> List(vecs3, a -> [x, a])));
pos := function(e) return Position(elts, e); end;
mul := function(e, f) return [e[1] + f[1], e[2] + f[2] + coc(e[1], f[1])]; end;
tab := List(elts, e -> List(elts, f -> pos(mul(e, f))));
Q := GroupByMultiplicationTable(tab);
Print("|Q| = ", Size(Q), " class ", NilpotencyClassOfGroup(Q), "\n");
els := GeneratorsOfGroup(Q);  # not needed
Elt := function(x, a) return Elements(Q)[pos([x,a])]; end;   # Elements(Q) ordering = table ordering? check:
# GroupByMultiplicationTable elements are numbered as in the table; use the canonical elements list:
Qelts := AsSSortedList(Q);
mk := function(e) return Qelts[pos(e)]; end;
# check that mk respects the table: mk(e)*mk(f) = mk(mul(e,f))
ok := ForAll([1..20], i -> ForAll([1..20], j -> mk(elts[i])*mk(elts[j]) = mk(mul(elts[i],elts[j]))));
Print("multiplication check: ", ok, "\n");
u12 := [o,z,z]; u13 := [z,o,z]; u23 := [z,z,o];
sub := function(cond) return Subgroup(Q, List(Filtered(elts, cond), mk)); end;
inblock := function(x, i) return ForAll([1..3], j -> j = i or blk(x,j) = [z,z]); end;
inspan := function(a, gens) return a in Subspace(F^3, gens); end;
N := List([1..3], i -> sub(e -> inblock(e[1], i) and inspan(e[2], Filtered([w[i][1],w[i][2],w[i][3]], v -> v <> w[i][i] or true))));
# N_i = {(x,a): x in block i, a in <u_ij, u_ik>}
Nsub := [ sub(e -> inblock(e[1],1) and inspan(e[2], [u12,u13])),
          sub(e -> inblock(e[1],2) and inspan(e[2], [u12,u23])),
          sub(e -> inblock(e[1],3) and inspan(e[2], [u13,u23])) ];
Print("|N_i| = ", List(Nsub, Size), " normal: ", List(Nsub, S -> IsNormal(Q, S)), "\n");
Print("|N1 meet N2 meet N3| = ", Size(Intersection(Nsub)), "\n");
A0 := sub(e -> e[1] = Zero(F^6) and inspan(e[2], [u12+u13, u13+u23]));
Hhat := sub(e -> blk(e[1],1)+blk(e[1],2)+blk(e[1],3) = [z,z]);   # preimage of ker s
Print("|Hhat| = ", Size(Hhat), " |A0| = ", Size(A0), "\n");
# find H: index-2 subgroup of Hhat, normal in Q, containing A0 but not A, with H N_i = Q and Q/H nonabelian
A := sub(e -> e[1] = Zero(F^6));
found := false;
for H in Filtered(List(ConjugacyClassesSubgroups(Hhat), Representative), S -> Index(Hhat, S) = 2) do
  for Hc in AsList(ConjugacyClassSubgroups(Hhat, H)) do
    if not IsNormal(Q, Hc) then continue; fi;
    if Intersection(Hc, A) <> A0 then continue; fi;
    if not ForAll(Nsub, Ni -> Size(ClosureGroup(Hc, Ni)) = Size(Q)) then continue; fi;
    P := Q / Hc;
    Print("FOUND H: |H| = ", Size(Hc), " Q/H = ", StructureDescription(P), " abelian: ", IsAbelian(P), "\n");
    found := true; break;
  od;
  if found then break; fi;
od;
Print("FINISHED\n"); QUIT;
