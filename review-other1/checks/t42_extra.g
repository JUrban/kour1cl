# consistency with Kida's computation: the order-96 group K and its subgroups must be monomial
F2 := GF(2);;
perm2mat := function(p) local M,i; M:=NullMat(5,5,F2); for i in [1..4] do M[i^p][i]:=One(F2); od; M[5][5]:=One(F2); return M; end;;
trans := function(v) local M,i; M:=IdentityMat(5,F2); for i in [1..4] do M[i][5]:=v[i]*One(F2); od; return M; end;;
el := function(v,g) return trans(v)*perm2mat(g); end;;
K := Group(el([1,1,0,0],()), el([0,1,1,0],()), el([0,0,1,1],()), el([0,0,0,0],(1,2)(3,4)), el([0,0,0,0],(1,3)(2,4)), el([0,0,0,0],(2,3,4)));;
Kp := Image(IsomorphismPermGroup(K));;
Print("|K| = ", Size(Kp), " IdGroup = ", IdGroup(Kp), " IsMonomial = ", IsMonomial(Kp), "\n");
Ee1 := Subgroup(K, [el([1,1,0,0],()), el([0,1,1,0],()), el([0,0,1,1],())]);;
Print("E normal in K: ", IsNormal(K,Ee1), " |E| = ", Size(Ee1), " elementary abelian: ", IsElementaryAbelian(Ee1), "\n");
A4 := Subgroup(K, [el([0,0,0,0],(1,2)(3,4)), el([0,0,0,0],(1,3)(2,4)), el([0,0,0,0],(2,3,4))]);;
Print("A4 complement: ", Size(A4), " ", StructureDescription(A4), " E cap A4 = ", Size(Intersection(Ee1,A4)), "\n");
Print("all groups of order <= 240 that are non-monomial: smallest orders: ",
  Filtered([1..240], n -> ForAny([1..NrSmallGroups(n)], i -> not IsMonomial(SmallGroup(n,i)))), "\n");
QUIT;
