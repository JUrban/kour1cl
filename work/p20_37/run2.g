Read("/project/work/p20_37/chain.g");
simp := AllSmallNonabelianSimpleGroups([34441..10^6]);
for S in simp do
  G := S; if not IsPermGroup(G) then G := Image(IsomorphismPermGroup(G)); fi;
  Print(StructureDescription(S), " |G|=", Size(G), " missing: ", Missing(G), "\n");
od;
Print("FINISHED\n"); QUIT;
