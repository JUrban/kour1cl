# E.1 (13.19): the order-256 example Q <= D^4 with H = ker(phi), Q/H = D8, both subdirect
z := Z(2);;
dd := function(a,b,c) return [[1,a,c],[0,1,b],[0,0,1]]*z^0; end;;
D := Group(dd(1,0,0), dd(0,1,0));;
Print("|D| = ", Size(D), " ", StructureDescription(D), "\n");
elts := [];;
for a in Tuples([0,1],2) do for b in Tuples([0,1],2) do for C in Tuples([0,1],4) do
  Add(elts, [a, b, C]);
od; od; od;
tup := function(x) return [dd(x[1][1],x[2][1],x[3][1]), dd(x[1][1],x[2][2],x[3][2]),
                           dd(x[1][2],x[2][1],x[3][3]), dd(x[1][2],x[2][2],x[3][4])]; end;;
DP := DirectProduct(D,D,D,D);;
emb := List([1..4], i -> Embedding(DP, i));;
gens := Set(List(elts, x -> Product([1..4], i -> Image(emb[i], tup(x)[i]))));;
Q := Subgroup(DP, gens);;
Print("|Q| = ", Size(Q), "\n");
phi := function(x) return dd((x[1][1]+x[1][2]) mod 2, (x[2][1]+x[2][2]) mod 2, Sum(x[3]) mod 2); end;;
hom := GroupHomomorphismByImages(Q, D, List(elts, x -> Product([1..4], i -> Image(emb[i], tup(x)[i]))), List(elts, phi));;
Print("phi is a homomorphism: ", hom <> fail, "\n");
if hom <> fail then
  H := Kernel(hom);;
  Print("|H| = ", Size(H), "  Q/H = ", StructureDescription(Image(hom)), "\n");
  Print("Q subdirect (projections onto each factor onto D): ",
    List([1..4], i -> Size(Image(Projection(DP,i), Q)) = 8), "\n");
  Print("H subdirect: ", List([1..4], i -> Size(Image(Projection(DP,i), H)) = 8), "\n");
  Print("H contains the diagonal: ", ForAll(GeneratorsOfGroup(D), g -> Product([1..4], i -> Image(emb[i], g)) in H), "\n");
  Print("Q/H is not regular: s^2 = t^2 = 1 but (st)^2 <> 1 in D8: ",
    IsOne(dd(1,0,0)^2) and IsOne(dd(0,1,0)^2) and not IsOne((dd(1,0,0)*dd(0,1,0))^2), "\n");
fi;
QUIT;
