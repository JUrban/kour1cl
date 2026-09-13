# Problem 21.29 (Burness-Giudici): G primitive on Omega with a regular suborbit.
# For all alpha, beta, is there gamma with G_{alpha,gamma} = G_{beta,gamma} = 1 ?
# Since the relation R = {(a,c): G_{a,c}=1} is symmetric and G-invariant, it suffices to fix alpha=1
# and let beta range over orbit representatives of G_1 on Omega \ {1}.
Check2129 := function(G, n)
  local stab, orbs, reg, N1, reps, b, g, Nb, bad;
  stab := Stabilizer(G, 1);
  orbs := Orbits(stab, [2..n]);
  reg := Filtered(orbs, o -> Length(o) = Size(stab));
  if Length(reg) = 0 then return fail; fi;   # no regular suborbit
  N1 := Set(Concatenation(reg));
  bad := [];
  for b in List(orbs, o -> o[1]) do
    g := RepresentativeAction(G, 1, b);
    Nb := OnSets(N1, g);
    if Length(Intersection(N1, Nb)) = 0 then Add(bad, b); fi;
  od;
  return bad;
end;
RunDegrees := function(lo, hi)
  local n, k, G, res, cnt;
  cnt := 0;
  for n in [lo..hi] do
    for k in [1..NrPrimitiveGroups(n)] do
      G := PrimitiveGroup(n, k);
      if Size(G) > n*(n-1) then continue; fi;   # regular suborbit forces |G_alpha| <= n-1
      res := Check2129(G, n);
      if res = fail then continue; fi;
      cnt := cnt + 1;
      if Length(res) > 0 then
        Print("COUNTEREXAMPLE: PrimitiveGroup(", n, ",", k, ") = ", G, " size ", Size(G), " bad betas ", res, "\n");
      fi;
    od;
    if n mod 100 = 0 then Print("done degree ", n, " groups-with-regular-suborbit so far: ", cnt, "\n"); fi;
  od;
  Print("FINISHED degrees ", lo, "..", hi, " groups checked: ", cnt, "\n");
end;
