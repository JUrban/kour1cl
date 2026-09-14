Read("/project/work/p20_21/test2021_fn.g");
RunOrders := function(list)
  local n, k, cnt;
  for n in list do
    cnt := 0;
    for k in [1..NrSmallGroups(n)] do
      if Test2021(SmallGroup(n,k)) then Print("CANDIDATE ", [n,k], "\n"); cnt := cnt + 1; fi;
    od;
    Print("done order ", n, " (", NrSmallGroups(n), " groups) candidates ", cnt, "\n");
  od;
  Print("FINISHED\n");
end;
