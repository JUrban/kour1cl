Read("/project/work/p16_14/ext.g");
# for H of order 128 with d(H)=5: for each involution h with l_h = 0, record (central?, in Phi?, in H'?, square of an element?)
stats := rec();
for k in [2150..2318] do
  H := SmallGroup(128, k);
  PhiH := FrattiniSubgroup(H); ZH := Centre(H); DH := DerivedSubgroup(H);
  cd := CocycleData(H);
  sq := Set(List(Elements(H), x -> x^2));
  types := [];
  for i in [1..Length(cd.inv)] do
    if IsZero(cd.rows[i]) then
      h := cd.inv[i];
      AddSet(types, [h in ZH, h in PhiH, h in DH, h in sq]);
    fi;
  od;
  key := String(types);
  if not IsBound(stats.(key)) then stats.(key) := 0; fi;
  stats.(key) := stats.(key) + 1;
od;
Print(stats, "\n"); QUIT;
