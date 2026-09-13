Read("/project/work/p21_113/lp_export.g");
out := "/project/work/p21_113/lp_data.jsonl";
PrintTo(out, "");
for n in [2..120] do
  if Length(PrimeDivisors(n)) < 2 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, k);
    if IsNilpotent(G) then continue; fi;
    for p in PrimeDivisors(n) do ExportLP(G, p, out); od;
  od;
od;
Print("FINISHED\n"); QUIT;
