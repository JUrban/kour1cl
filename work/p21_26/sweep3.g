Read("/project/work/p21_26/check2.g");
# heavy orders: run ids in [klo..khi] of order n
RunIds := function(n, klo, khi)
  local k, G, cnt, r, primes;
  cnt := 0;
  for k in [klo..khi] do
    G := SmallGroup(n, k);
    if IsNilpotent(G) then continue; fi;
    primes := Filtered(PrimeDivisors(n), p -> not IsNormal(G, SylowSubgroup(G, p)));
    if Length(primes) < 2 then continue; fi;
    cnt := cnt + 1;
    r := Check2126b(G, 50);
    if not r[1] then Print("COUNTEREXAMPLE: SmallGroup(", n, ",", k, ") ", StructureDescription(G), "\n"); fi;
    if k mod 20000 = 0 then Print("progress ", n, " id ", k, " checked ", cnt, "\n"); fi;
  od;
  Print("FINISHED order ", n, " ids ", klo, "..", khi, " groups with >=2 non-normal Sylows checked ", cnt, "\n");
end;
