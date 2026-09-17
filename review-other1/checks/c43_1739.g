# C.43 (17.39): p odd, d>=1, G = P x| <t>, P Heisenberg-like of order p^{2d+1}; check p=3,d=1,2 and p=5,d=1
check := function(p,d)
  local V, els, mul, G, D, S, SN, Snorm, mn, k, combos, found, F, hc, sys;
  G := Group(());
  # build as matrix group over GF(p): upper unitriangular (d+2)x(d+2) with block sizes 1,d,1, times t = diag(1,-I_d,-1)
  F := GF(p);;
  mn := [];
  for k in [1..d] do
    V := IdentityMat(d+2,F);; V[1][k+1] := One(F);; Add(mn, V);
    V := IdentityMat(d+2,F);; V[k+1][d+2] := One(F);; Add(mn, V);
  od;
  V := IdentityMat(d+2,F);; V[1][d+2] := One(F);; Add(mn,V);
  V := IdentityMat(d+2,F);; for k in [2..d+2] do V[k][k] := -One(F); od; Add(mn, V);
  G := Group(mn);; G := Image(IsomorphismPcGroup(G));;
  Print("p=",p," d=",d," |G|=",Size(G)," expected ",2*p^(2*d+1),"  supersolvable:",IsSupersolvableGroup(G),
        " derived length:",DerivedLength(G)," |Z_inf|=",Size(UpperCentralSeries(G)[Length(UpperCentralSeries(G))]),
        " |Phi|=",Size(FrattiniSubgroup(G)),"\n");
  D := Intersection(List(SylowSystem(G), P -> Normalizer(G,P)));;
  SN := List(RightTransversal(G, Normalizer(G,D)), g -> D^g);;
  SN := Set(List(SN, X -> Set(AsList(X))));;
  Print("  number of system normalizers = ", Length(SN), " expected p^(d+1) = ", p^(d+1), "\n");
  found := false; k := 0;
  while not found do
    k := k+1;
    found := ForAny(Combinations([1..Length(SN)], k), c -> Length(Intersection(List(c, i->SN[i]))) = 1);
  od;
  Print("  least number with trivial intersection = ", k, " expected ", d+1, "\n");
end;;
check(3,1);; check(3,2);; check(5,1);;
QUIT;
