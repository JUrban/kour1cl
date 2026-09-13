# Independent verification for 18.46: for every group H of order < 128 divisible by 8, no subgroup S ~= D8 of H
# consists of squares of H. Method: subgroup classes (independent of IsomorphicSubgroups).
D8id := IdGroup(DihedralGroup(8));
bad := [];
for m in [8, 16 .. 120] do
  for k in [1..NrSmallGroups(m)] do
    H := SmallGroup(m, k);
    sq := Set(List(Elements(H), h -> h^2));
    if Size(sq) < 8 then continue; fi;
    for c in ConjugacyClassesSubgroups(H) do
      S := Representative(c);
      if Size(S) <> 8 or IdGroup(S) <> D8id then continue; fi;
      if IsSubset(sq, Elements(S)) then Add(bad, [m, k]); Print("FOUND H of order ", m, " id ", k, "\n"); fi;
    od;
  od;
  Print("checked order ", m, "\n");
od;
Print("groups of order < 128 containing a D8 of squares: ", bad, "\n");
# order 128: the wreath product D8 wr C2 works; count all working groups of order 128
W := WreathProduct(DihedralGroup(8), SymmetricGroup(2));
sq := Set(List(Elements(W), h -> h^2));
ok := ForAny(ConjugacyClassesSubgroups(W), c -> Size(Representative(c)) = 8 and IdGroup(Representative(c)) = D8id and IsSubset(sq, Elements(Representative(c))));
Print("D8 wr C2 (order ", Size(W), ", id ", IdGroup(W), ") contains a D8 consisting of squares: ", ok, "\n");
cnt := 0;
for k in [1..NrSmallGroups(128)] do
  H := SmallGroup(128, k);
  sq := Set(List(Elements(H), h -> h^2));
  if Size(sq) < 8 then continue; fi;
  if ForAny(ConjugacyClassesSubgroups(H), c -> Size(Representative(c)) = 8 and IdGroup(Representative(c)) = D8id and IsSubset(sq, Elements(Representative(c)))) then cnt := cnt + 1; Print("order 128 id ", k, " works\n"); fi;
od;
Print("number of groups of order 128 that work: ", cnt, "\n");
Print("FINISHED\n"); QUIT;
