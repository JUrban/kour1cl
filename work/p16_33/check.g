# 16.33 (Glauberman): p-group with abelian A of order p^n: exists abelian B of order p^n normal in <B^G>? (a) p=3 (b) p=2; (c) elementary abelian, p=3
CheckOrder := function(n)
  local p, k, G, ccs, abel, m, ok, B, N, el, me, okc, cnt;
  p := PrimeDivisors(n)[1]; cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    ccs := List(ConjugacyClassesSubgroups(G), Representative);
    abel := Filtered(ccs, IsAbelian);
    m := Maximum(List(abel, Size));
    # for each order p^j <= m that occurs, check property for the maximal ones (all j occurring)
    for j in Set(List(abel, Size)) do
      ok := ForAny(Filtered(abel, B -> Size(B) = j), B -> IsNormal(NormalClosure(G, B), B));
      if not ok then Print("COUNTEREXAMPLE (abelian) SmallGroup(", n, ",", k, ") order ", j, "\n"); fi;
    od;
    if p = 3 then
      el := Filtered(abel, IsElementaryAbelian);
      for j in Set(List(el, Size)) do
        okc := ForAny(Filtered(el, B -> Size(B) = j), B -> IsNormal(NormalClosure(G, B), B));
        if not okc then Print("COUNTEREXAMPLE (elem. abelian) SmallGroup(", n, ",", k, ") order ", j, "\n"); fi;
      od;
    fi;
    cnt := cnt + 1;
  od;
  Print("done order ", n, " groups ", cnt, "\n");
end;
for n in [8,16,32,64,128,256, 27,81,243,729,2187] do CheckOrder(n); od;
Print("FINISHED\n"); QUIT;
