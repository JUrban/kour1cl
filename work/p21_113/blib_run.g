Read("/project/work/p21_113/brauer_lib.g");
names := AllCharacterTableNames(IsDuplicateTable, false, Size, [1..10^7]);
Print("number of tables: ", Length(names), "\n");
for nm in names do
  CheckTable(nm);
od;
Print("FINISHED\n"); QUIT;
