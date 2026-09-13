# 20.100 (Sun, n=4): G with no elements of order 2..5 (|G| coprime to 30). Export multiplication tables (element indices) of all groups of such orders <= 300.
for n in [7..300] do
  if Gcd(n, 30) <> 1 then continue; fi;
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); elts := Elements(G);
    out := OutputTextFile(Concatenation("/project/work/p20_100/tab_", String(n), "_", String(k), ".txt"), false);
    SetPrintFormattingStatus(out, false);
    WriteLine(out, String(n));
    for x in elts do WriteLine(out, JoinStringsWithSeparator(List(elts, y -> String(Position(elts, x*y))), " ")); od;
    CloseStream(out);
  od;
od;
Print("FINISHED\n"); QUIT;
