Read("/project/work/p21_32/crit.g");
ids := DerivedIds(300);
Print("derived-subgroup ids found (order<=32) among H of order<=300 (skipping orders with >3000 groups): ", Length(ids), "\n");
for n in [1..32] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k);
    crit := HasQ(G);
    found := [n,k] in ids;
    if crit <> found then
      Print("MISMATCH ", [n,k], " ", StructureDescription(G), " crit=", crit, " found=", found, " Z=", Size(Center(G)), "\n");
    fi;
  od;
od;
Print("D8: crit=", HasQ(DihedralGroup(8)), " S3: crit=", HasQ(SymmetricGroup(3)), " Q8: ", HasQ(QuaternionGroup(8)), "\n");
QUIT;
