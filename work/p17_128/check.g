# 17.128 (Jabara): T p-group, A = C_p^2 acting, P = T A, every element of P \ T of order p => exp(T) = p ?
CheckOrder := function(n)
  local p, k, P, cnt, T, comp, A, ok, x, cls, c;
  p := PrimeDivisors(n)[1]; cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    P := SmallGroup(n,k);
    for T in NormalSubgroups(P) do
      if Index(P, T) <> p^2 or not IsElementaryAbelian(P/T) then continue; fi;
      comp := ComplementClassesRepresentatives(P, T);
      if Length(comp) = 0 then continue; fi;
      # all elements outside T of order p ?
      ok := true;
      for c in ConjugacyClasses(P) do
        x := Representative(c);
        if not x in T and Order(x) <> p then ok := false; break; fi;
      od;
      if not ok then continue; fi;
      cnt := cnt + 1;
      if Exponent(T) <> p then Print("COUNTEREXAMPLE P=SmallGroup(", n, ",", k, ") T of order ", Size(T), " exponent ", Exponent(T), " abelian: ", IsAbelian(T), "\n"); fi;
    od;
  od;
  Print("done order ", n, " configurations ", cnt, "\n");
end;
for n in [27, 81, 243, 729, 2187, 125, 625, 3125, 15625, 343, 2401, 16807] do CheckOrder(n); od;
Print("FINISHED\n"); QUIT;
