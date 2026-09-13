# 11.17(b) (Brandl): d(G) = least d such that [x,_r y] = [x,_{r+d} y] is a law for some r. For simple G, does exp(G) | d(G)?
# Period of the eventually periodic Engel sequence x_{i+1} = [x_i, y]; d(G) = lcm of periods over all pairs.
EngelPeriod := function(x, y)
  local seen, i, z, pos;
  seen := []; z := x; i := 0;
  while true do
    pos := Position(seen, z);
    if pos <> fail then return i - (pos - 1); fi;
    Add(seen, z); z := Comm(z, y); i := i + 1;
  od;
end;
DOfGroup := function(G)
  local d, y, C, orbs, x, cl;
  d := 1;
  for cl in ConjugacyClasses(G) do
    y := Representative(cl);
    C := Centralizer(G, y);
    # x up to C-conjugacy: iterate over orbits of C on G by conjugation
    orbs := OrbitsDomain(C, G, OnPoints);
    for x in List(orbs, o -> o[1]) do
      d := Lcm(d, EngelPeriod(x, y));
    od;
  od;
  return d;
end;
for G in [PSL(3,3), PSU(3,3), MathieuGroup(11), PSL(3,4), PSU(4,2), Sz(8), PSU(3,4), MathieuGroup(12), PSL(3,5), PSU(3,5), J1] do
  d := DOfGroup(G); e := Exponent(G);
  Print(Name(G), ": d(G)=", d, " exp(G)=", e, " exp divides d: ", d mod e = 0, "\n");
od;
Print("FINISHED\n"); QUIT;
