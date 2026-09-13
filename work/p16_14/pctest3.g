Read("/project/work/p16_14/pcover_filter.g");
t := Runtime(); c3 := 0; cS := 0;
for k in [6249624..6249624+299] do
  H := SmallGroup(512, k);
  if F3prime(H) then c3 := c3 + 1; else cS := cS + 1; fi;
od;
Print("F3' first: killed ", c3, " survivors ", cS, " time per group ", Float((Runtime() - t)/300), " ms\n");
t := Runtime(); c2 := 0;
for k in [6249624..6249624+299] do
  H := SmallGroup(512, k);
  if not F2(H) then c2 := c2 + 1; fi;
od;
Print("F2 alone: killed ", c2, " time per group ", Float((Runtime() - t)/300), " ms\n");
QUIT;
