Read("/project/work/p16_14/pcover_filter.g");
bad := 0;
for k in [26973..27972] do
  res := AnalyseFast(256, k, 2, "H256", false);
  Print(k, " ", res, "\n");
od;
QUIT;
