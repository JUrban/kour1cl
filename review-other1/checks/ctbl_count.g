LoadPackage("ctbllib");;
n := AllCharacterTableNames();;
Print("character table names in CTblLib: ", Length(n), "\n");
Print("tables of simple groups: ", Length(AllCharacterTableNames(IsSimple, true)), "\n");
Print("ordinary tables with known 2-modular table (sample check on first 200): ",
  Number(n{[1..200]}, s -> CharacterTable(s) mod 2 <> fail), "\n");
QUIT;
