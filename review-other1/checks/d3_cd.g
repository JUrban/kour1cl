# D.3: Chermak-Delgado subgroup computed by hand: intersection of the subgroups of maximal measure |H||C_X(H)|
bad := 0;; tested := 0;;
for n in [8,12,16,18,24,27,32,36,48] do
  for i in [1..NrSmallGroups(n)] do
    Xg := SmallGroup(n,i);;
    if not IsAbelian(Xg) then
      subs := List(ConjugacyClassesSubgroups(Xg), Representative);;
      all := Concatenation(List(ConjugacyClassesSubgroups(Xg), c -> AsList(c)));;
      meas := List(all, H -> Size(H)*Size(Centralizer(Xg,H)));;
      mx := Maximum(meas);;
      Dcd := Intersection(Filtered(all, H -> Size(H)*Size(Centralizer(Xg,H)) = mx));;
      j := Minimum(List(Filtered(subs, IsAbelian), A -> Index(Xg,A)));;
      tested := tested + 1;
      if not (IsAbelian(Dcd) and IsNormal(Xg,Dcd) and Index(Xg,Dcd) <= j^2) then
        bad := bad + 1;
        Print("VIOLATION ", IdGroup(Xg), " j=", j, " index=", Index(Xg,Dcd),
              " abelian:", IsAbelian(Dcd), "\n");
      fi;
    fi;
  od;
od;
Print("nonabelian groups tested: ", tested, "  violations: ", bad, "\n");
QUIT;
