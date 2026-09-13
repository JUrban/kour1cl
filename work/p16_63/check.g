# 16.63 / 15.29: p-groups with |Aut G| = |G| (odd p), and 2-groups with Aut(G) ~= G
for n in [27, 81, 243, 729, 2187, 125, 625, 3125, 15625, 343, 2401, 16807, 1331, 14641, 2197, 4913] do
  cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    A := AutomorphismGroup(G);
    if Size(A) = n then Print("FOUND odd: SmallGroup(", n, ",", k, ") |Aut|=|G|\n"); cnt := cnt+1; fi;
  od;
  Print("done order ", n, " found ", cnt, "\n");
od;
for n in [8, 16, 32, 64, 128, 256] do
  cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsAbelian(G) then continue; fi;
    A := AutomorphismGroup(G);
    if Size(A) = n and IdGroup(A) = [n,k] then Print("FOUND 2-group Aut(G)~=G: SmallGroup(", n, ",", k, ") ", StructureDescription(G), "\n"); cnt := cnt+1; fi;
  od;
  Print("done order ", n, " found ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
