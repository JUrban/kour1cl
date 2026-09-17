# Check of Theorem 4.2 (Problem 21.68): semi-abelian non-monomial group of order 2592
F2 := GF(2);;
perm2mat := function(p) local M,i; M:=NullMat(5,5,F2); for i in [1..4] do M[i^p][i]:=One(F2); od; M[5][5]:=One(F2); return M; end;;
trans := function(v) local M,i; M:=IdentityMat(5,F2); for i in [1..4] do M[i][5]:=v[i]*One(F2); od; return M; end;;
el := function(v,g) return trans(v)*perm2mat(g); end;;   # (v,g): x -> v + g(x)
z := el([1,1,1,1],());; x := el([1,0,1,0],(1,2)(3,4));; y := el([1,0,0,1],(1,3)(2,4));; r := el([0,0,0,0],(2,3,4));;
K := Group(el([1,1,0,0],()), el([0,1,1,0],()), el([0,0,1,1],()), el([0,0,0,0],(1,2)(3,4)), el([0,0,0,0],(1,3)(2,4)), r);;
Print("|K| = ",Size(K),"\n");
Print("relations: ", [x^2=z, y^2=z, (x*y)^2=z, IsOne(z^2), IsOne(r^3), r*x*r^-1=y, r*y*r^-1=x*y], "\n");
H := Subgroup(K,[x,y,r]);; Print("|H| = ",Size(H),"  StructureDescription(H) = ",StructureDescription(H),"\n");
hom := ActionHomomorphism(K, RightCosets(K,H), OnRight);;
# G = B x| K realised inside AGL(3,3) x K (diagonal), B = sum-zero vectors of F_3^4 (right action)
F3 := GF(3);;
Bb := [[1,-1,0,0],[0,1,-1,0],[0,0,1,-1]]*One(F3);;
aff := function(m3, v) local M; M := IdentityMat(4,F3); M{[1..3]}{[1..3]} := m3; M[4]{[1..3]} := v; return M; end;;
coordMat := function(pm) return List(Bb, b -> SolutionMat(Bb, b*pm)); end;;
KP := Image(IsomorphismPermGroup(K));; isoKP := IsomorphismPermGroup(K);;
gensK := GeneratorsOfGroup(K);;
gensG := Concatenation(
  List(IdentityMat(3,F3), v -> DirectProductElement([aff(IdentityMat(3,F3), v), One(KP)])),
  List(gensK, g -> DirectProductElement([aff(coordMat(PermutationMat(Image(hom,g),4,F3)), [0,0,0]*One(F3)), Image(isoKP,g)])));;
G0 := Group(gensG);;
iso := IsomorphismPermGroup(G0);; G := Image(iso);;
Print("|G| = ", Size(G), "\n");
Print("IsMonomial(G) = ", IsMonomial(G), "\n");
ct := CharacterTable(G);; irr := Irr(ct);;
Print("character degrees (collected) = ", Collected(List(irr, c->c[1])), "\n");
nm := Filtered(irr, c -> not IsMonomialCharacter(c));;
Print("degrees of non-monomial irreducibles = ", List(nm, c->c[1]), "\n");
# the chain 1 < C3 < A4 < K < G with abelian normal complements: check B normal abelian of order 27 with complement K
Bsub := Subgroup(G, List(gensG{[1..3]}, g->Image(iso,g)));;
Ksub := Subgroup(G, List(gensG{[4..Length(gensG)]}, g->Image(iso,g)));;
Print("B normal abelian, |B|, |K|, B cap K: ", IsNormal(G,Bsub), " ", IsAbelian(Bsub), " ", Size(Bsub), " ", Size(Ksub), " ", Size(Intersection(Bsub,Ksub)), "\n");
QUIT;
