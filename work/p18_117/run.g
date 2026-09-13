Read("/project/work/p18_117/coprime.g");
for pair in [[MathieuGroup(11),"M11"],[MathieuGroup(12),"M12"],[MathieuGroup(22),"M22"],[MathieuGroup(23),"M23"],[MathieuGroup(24),"M24"]] do
  CheckCoprimeCommutators(pair[1], pair[2], 200000);
od;
LoadPackage("atlasrep");
for nm in ["J1","J2","HS","J3","McL","He","Co3"] do
  G := AtlasGroup(nm);
  if G = fail then Print(nm, ": not available\n"); continue; fi;
  CheckCoprimeCommutators(G, nm, 400000);
od;
Print("FINISHED\n"); QUIT;
