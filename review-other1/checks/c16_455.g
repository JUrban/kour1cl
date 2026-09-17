# C.16 (4.55): 5-modular data of 3.A7
t := CharacterTable("3.A7");; m := t mod 5;;
irr := Irr(t);; ibr := Irr(m);;
dec := DecompositionMatrix(m);;
Print("ordinary degrees: ", List(irr, c->c[1]), "\n");
Print("Brauer degrees:   ", List(ibr, c->c[1]), "\n");
# faithful characters with a fixed nontrivial central character
cen := ClassPositionsOfCentre(t);; z := First(cen, i -> OrdersClassRepresentatives(t)[i]=3);;
faith := Filtered([1..Length(irr)], i -> irr[i][z] = E(3)*irr[i][1]);;
Print("faithful (central char w) positions: ", faith, " degrees ", List(faith, i->irr[i][1]), "\n");
cols := Filtered([1..Length(ibr)], j -> ForAny(faith, i -> dec[i][j] <> 0));;
Print("Brauer columns used: ", cols, " degrees ", List(cols, j->ibr[j][1]), "\n");
for i in faith do Print("  ", i, " deg ", irr[i][1], " row ", dec[i]{cols}, "\n"); od;
# PIM degrees (absolute)
Print("PIM degrees: ", List(cols, j -> Sum(List([1..Length(irr)], i -> dec[i][j]*irr[i][1]))), "\n");
# rational Galois orbits of ordinary characters
orbs := Set(List([1..Length(irr)], i -> Set(Filtered([1..Length(irr)], k -> ForAny(PrimeResidues(Conductor(irr[i])), g -> GaloisCyc(irr[i], g) = irr[k])))));;
Print("Galois orbits touching faithful set: ", Filtered(orbs, O -> Intersection(O, faith) <> []), "\n");
Print("5-blocks (ordinary char positions): ", List(BlocksInfo(m), b -> b.ordchars), "\n");
QUIT;
