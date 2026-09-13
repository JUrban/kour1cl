Read("/project/work/p20_21/test2021_fn.g");
Weak := function(K)   # cheap filter: normal I, I' with K/I ~= V4, K/I' ~= C4, |I| = |I'|, same IdGroup
  local ns, Vs, Cs, idsC;
  ns := Filtered(NormalSubgroups(K), N -> Index(K,N) = 4);
  Vs := Filtered(ns, N -> not IsCyclic(K/N)); Cs := Filtered(ns, N -> IsCyclic(K/N));
  if Length(Vs) = 0 or Length(Cs) = 0 then return false; fi;
  idsC := Set(List(Cs, IdGroup));
  return ForAny(Vs, I -> IdGroup(I) in idsC);
end;
Run512 := function(lo, hi)
  local k, K, cnt;
  cnt := 0;
  for k in [lo..hi] do
    K := SmallGroup(512, k);
    if not Weak(K) then continue; fi;
    cnt := cnt + 1;
    if Test2021(K) then Print("CANDIDATE 512 id ", k, "\n"); fi;
    if k mod 2000 = 0 then Print("progress ", k, " weak-passing so far ", cnt, "\n"); fi;
  od;
  Print("FINISHED 512 ids ", lo, "..", hi, " weak-passing ", cnt, "\n");
end;
