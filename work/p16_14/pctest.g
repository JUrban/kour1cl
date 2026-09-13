Read("/project/work/p16_14/pcover_filter.g");
# validate on order 256 rank 5 (all known to fail F2/F3) and time it
t := Runtime(); cnt := rec(F2 := 0, F3 := 0, S := 0, BAD := 0);
for k in [26973..27972] do
  res := AnalyseFast(256, k, 2, "H256", k mod 50 = 0);
  cnt.(res) := cnt.(res) + 1;
od;
Print(cnt, " time for 1000 groups: ", Runtime() - t, " ms\n");
t := Runtime(); cnt := rec(F2 := 0, F3 := 0, S := 0, BAD := 0);
for k in [420515..420515+999] do
  res := AnalyseFast(512, k, 2, "H512", k mod 50 = 0);
  cnt.(res) := cnt.(res) + 1;
od;
Print(cnt, " time for 1000 groups of order 512: ", Runtime() - t, " ms\n");
QUIT;
