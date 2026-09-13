Read("/project/work/p16_14/pcover_filter.g");
cnt := rec(F2 := 0, F3 := 0, S := 0, BAD := 0, rank := 0);
for k in [2452483..2960474] do
  res := AnalyseFast(512, k, 2, "H512r2", k mod 200 = 0);
  cnt.(res) := cnt.(res) + 1;
  if k mod 20000 = 0 then Print("progress ", k, " ", cnt, "\n"); fi;
od;
Print("FINISHED ids 2452483..2960474 ", cnt, "\n"); QUIT;
