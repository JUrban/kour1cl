fval := function(G) local ccs; ccs := ConjugacyClassesSubgroups(G);
  return Length(Set(List(Filtered(ccs, c -> Size(c) > 1), c -> Size(Representative(c))))); end;
nord := function(G) return Length(Set(List(ConjugacyClassesSubgroups(G), c -> Size(Representative(c))))); end;
Mp := function(p, n) local F, x, y; F := FreeGroup("x","y"); x := F.1; y := F.2;
  return Image(IsomorphismPcGroup(F / [x^(p^(n-1)), y^p, y^-1*x*y*x^-(1+p^(n-2))])); end;
for p in [7] do for n in [3,4] do for r in [0,1] do
  P := DirectProduct(Mp(p,n), CyclicGroup(p^r));
  Print("p=",p," n=",n," r=",r," |P|=",Size(P)," |Ord|=",nord(P)," f=",fval(P)," (expected ", n+r+1, ", ", r+1, ")\n");
od; od; od;
G := DirectProduct(AlternatingGroup(5), Mp(7,3));
Print("A5 x M_343: f=", fval(G), " expected 30\n");
QUIT;
