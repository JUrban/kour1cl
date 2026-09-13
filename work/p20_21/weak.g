# weak condition: normal I, I' with I ~= I', K/I ~= V4, K/I' ~= C4
for n in [4, 8 .. 128] do
  for k in [1..NrSmallGroups(n)] do
    K := SmallGroup(n,k);
    ns := Filtered(NormalSubgroups(K), N -> Index(K,N) = 4);
    Vs := Filtered(ns, N -> not IsCyclic(K/N)); Cs := Filtered(ns, N -> IsCyclic(K/N));
    if Length(Vs) = 0 or Length(Cs) = 0 then continue; fi;
    for I in Vs do for J in Cs do
      if IdGroup(I) = IdGroup(J) then Print("WEAK: K = ", [n,k], " ", StructureDescription(K), " I = ", StructureDescription(I), " (I=", IdGroup(I), ")\n"); fi;
    od; od;
  od;
  Print("done ", n, "\n");
od;
QUIT;
