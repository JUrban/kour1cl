# 18.46 (Klyachko): every finite G embeds in H with every element of G a square in H, |H| <= 2|G|^2. Is 2|G|^2 sharp?
# Compute the minimal |H| for small G.
MinH := function(G, maxorder)
  local m, k, H, sq, embs, e, img, ok;
  for m in [Size(G)..maxorder] do
    if m mod Size(G) <> 0 then continue; fi;
    if NrSmallGroups(m) > 60000 then Print("   (skipping order ", m, ")\n"); continue; fi;
    for k in [1..NrSmallGroups(m)] do
      H := SmallGroup(m, k);
      sq := Set(List(Elements(H), h -> h^2));
      embs := IsomorphicSubgroups(H, G);
      for e in embs do
        img := Image(e);
        if ForAll(Elements(img), x -> x in sq) then return [m, k, StructureDescription(H)]; fi;
      od;
    od;
  od;
  return fail;
end;
for G in [CyclicGroup(2), CyclicGroup(4), SmallGroup(4,2), SymmetricGroup(3), CyclicGroup(6), CyclicGroup(8), SmallGroup(8,2), DihedralGroup(8), QuaternionGroup(8), SmallGroup(8,5), DihedralGroup(10), AlternatingGroup(4), DihedralGroup(12), SmallGroup(12,1), CyclicGroup(12), SmallGroup(12,5)] do
  r := MinH(G, 2*Size(G)^2);
  Print(StructureDescription(G), " |G|=", Size(G), " |G|^2=", Size(G)^2, " 2|G|^2=", 2*Size(G)^2, " minimal |H| = ", r, "\n");
od;
Print("FINISHED\n"); QUIT;
