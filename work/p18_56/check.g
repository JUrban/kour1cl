# 18.56 (Cutolo): finite 2-group G (|G|>2) with |H : H_G| <= 2 for all H <= G ("core-2"). Must G have an abelian subgroup of index 4?
IsCore2 := function(G) local c, H;
  for c in ConjugacyClassesSubgroups(G) do H := Representative(c);
    if Index(H, Core(G, H)) > 2 then return false; fi; od; return true; end;
for n in [4, 8, 16, 32, 64, 128, 256] do
  cnt := 0;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, k);
    if IsAbelian(G) then continue; fi;
    # cheap prefilter: <x^2> normal for all x
    if not ForAll(ConjugacyClasses(G), c -> IsNormal(G, Subgroup(G, [Representative(c)^2]))) then continue; fi;
    if not IsCore2(G) then continue; fi;
    cnt := cnt + 1;
    hasAb := ForAny(ConjugacyClassesSubgroups(G), c -> Index(G, Representative(c)) <= 4 and IsAbelian(Representative(c)));
    if not hasAb then Print("COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), " is core-2 with no abelian subgroup of index <= 4\n"); fi;
  od;
  Print("done order ", n, " core-2 groups: ", cnt, "\n");
od;
Print("FINISHED\n"); QUIT;
