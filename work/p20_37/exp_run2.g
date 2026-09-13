Read("/project/work/p20_37/export2.g");
simp := AllSmallNonabelianSimpleGroups([40001..300000]);
for S in simp do ExportCase(S, Concatenation("/project/work/p20_37/case_", String(Size(S)), ".txt")); od;
Print("FINISHED\n"); QUIT;
