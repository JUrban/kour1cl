Read("/project/work/p16_14/ext.g");
for k in [56083, 56084] do
  H := SmallGroup(256, k); cd := CocycleData(H);
  for i in [1..Length(cd.inv)] do
    if IsZero(cd.rows[i]) then
      h := cd.inv[i];
      Print(k, ": zero functional at h = ", h, " central: ", h in Centre(H), " in Phi: ", h in FrattiniSubgroup(H), " is square: ", ForAny(Elements(H), x -> x^2 = h), "\n");
    fi;
  od;
  # also: does the split extension (zero cocycle) give squares? sanity: count rows equal for h and h*z
  z := First(Elements(FrattiniSubgroup(H)), x -> Order(x) = 2);
  Print("  rows equal for h and hz (when both involutions): ", ForAll([1..Length(cd.inv)], i -> not (cd.inv[i]*z in cd.inv) or cd.rows[i] = cd.rows[Position(cd.inv, cd.inv[i]*z)]), "\n");
od;
QUIT;
