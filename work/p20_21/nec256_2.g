Read("/project/work/p20_21/test2021_fn.g");
for k in [9001..18000] do Test2021(SmallGroup(256,k)); if k mod 1000 = 0 then Print("progress ", k, "\n"); fi; od;
Print("FINISHED 256 ids 9001..18000\n"); QUIT;
