Read("/project/work/p20_21/t512.g");
for lo in [420515, 6249624, 7529607] do
  t := Runtime(); c := 0;
  for k in [lo..lo+39] do if Weak(SmallGroup(512,k)) then c := c + 1; fi; od;
  Print("start ", lo, ": ", Float((Runtime()-t)/40), " ms/group, weak-passing ", c, "\n");
od;
QUIT;
