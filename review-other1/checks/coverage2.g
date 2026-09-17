Print("transitive groups of degrees 2..8: ", Sum([2..8], d -> NrTransitiveGroups(d)), "\n");
LoadPackage("ctbllib");;
names := AllCharacterTableNames();;
pairs := 0;; have := 0;; miss := 0;;
for s in names do
  t := CharacterTable(s);
  if t <> fail then
    for p in PrimeDivisors(Size(t)) do
      pairs := pairs + 1;
      if (t mod p) <> fail then have := have + 1; else miss := miss + 1; fi;
    od;
  fi;
od;
Print("table/prime cases: ", pairs, "  with modular table: ", have, "  without: ", miss, "\n");
QUIT;
