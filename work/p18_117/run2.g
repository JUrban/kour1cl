Read("/project/work/p18_117/coprime2.g");
LoadPackage("atlasrep");
for nm in ["Co3", "Co2", "Suz", "Fi22", "ON", "Ru", "HN", "Ly", "Th", "Fi23", "Co1", "J4"] do
  G := AtlasGroup(nm);
  if G = fail then Print(nm, ": not available\n"); continue; fi;
  if IsPermGroup(G) and NrMovedPoints(G) > 200000 then Print(nm, ": degree too large (", NrMovedPoints(G), ")\n"); continue; fi;
  if not IsPermGroup(G) then Print(nm, ": not a permutation group\n"); continue; fi;
  Print(nm, ": degree ", NrMovedPoints(G), " order ", Size(G), "\n");
  FullCheck(G, nm, 300000, 3000);
od;
Print("FINISHED\n"); QUIT;
