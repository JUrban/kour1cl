fval := function(G) local ccs; ccs := ConjugacyClassesSubgroups(G);
  return Length(Set(List(Filtered(ccs, c -> Size(c) > 1), c -> Size(Representative(c))))); end;
nord := function(G) return Length(Set(List(ConjugacyClassesSubgroups(G), c -> Size(Representative(c))))); end;
Mp := function(p, n)  # M_{p^n} = <x,y | x^(p^(n-1)), y^p, x^y = x^(1+p^(n-2))>
  local F, x, y; F := FreeGroup("x","y"); x := F.1; y := F.2;
  return Image(IsomorphismPcGroup(F / [x^(p^(n-1)), y^p, y^-1*x*y*x^-(1+p^(n-2))]));
end;
for p in [7, 11] do for n in [3,4] do for r in [0,1,2] do
  P := DirectProduct(Mp(p,n), CyclicGroup(p^r));
  Print("p=",p," n=",n," r=",r," |P|=",Size(P)," |Ord|=",nord(P)," f=",fval(P)," (expected ", n+r+1, ", ", r+1, ")\n");
od; od; od;
A5 := AlternatingGroup(5);
for nr in [[3,0],[3,1],[4,0],[4,1]] do
  G := DirectProduct(A5, DirectProduct(Mp(7,nr[1]), CyclicGroup(7^nr[2])));
  Print("A5 x M_{7^", nr[1], "} x C_{7^", nr[2], "}: f=", fval(G), " expected ", 7*(nr[1]+nr[2]+1)+2*(nr[2]+1), "\n");
od;
Print("f(A5 x C7)=", fval(DirectProduct(A5, CyclicGroup(7))), " f(S5)=", fval(SymmetricGroup(5)), " f(L2(13))=", fval(PSL(2,13)), " f(C3xS5)=", fval(DirectProduct(CyclicGroup(3),SymmetricGroup(5))), "\n");
QUIT;
