Read("/project/work/p20_37/chain2.g");
simp := AllSmallNonabelianSimpleGroups([60..10^6]);
for S in simp do
  G := S; if not IsPermGroup(G) then G := Image(IsomorphismPermGroup(G)); fi;
  m := Missing2(G);
  Print(StructureDescription(S), " |G|=", Size(G), " missing after Thm 1: ", Filtered(m, a -> a*a <= Size(G)), "\n");
od;
Print("FINISHED\n"); QUIT;
