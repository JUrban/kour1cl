# D.3 (21.121(b)): abelian p'-subgroups C of Aut(P) satisfy |C| <= |P/Phi(P)| - 1
bad := 0;; tested := 0;;
for n in [4,8,9,16,25,27,32,49,81] do
  for i in [1..NrSmallGroups(n)] do
    P := SmallGroup(n,i);; if Size(P) = 1 then continue; fi;
    p := PrimeDivisors(Size(P))[1];;
    A := AutomorphismGroup(P);;
    bound := Size(P)/Size(FrattiniSubgroup(P)) - 1;;
    for H in List(ConjugacyClassesSubgroups(A), Representative) do
      if IsAbelian(H) and Size(H) mod p <> 0 then
        tested := tested + 1;
        if Size(H) > bound then bad := bad + 1;
          Print("VIOLATION: ", IdGroup(P), " |C| = ", Size(H), " bound ", bound, "\n"); fi;
      fi;
    od;
  od;
od;
Print("abelian p'-subgroups tested: ", tested, "  violations: ", bad, "\n");
# rho = log 60 / log 4 strictly between 2 and 3
Print("60 vs 16 and 64: ", 16 < 60, " ", 60 < 64, "  so 2 < log60/log4 < 3\n");
QUIT;
