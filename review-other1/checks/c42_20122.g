# C.42 (20.122): G = C_2^Omega x| (F_3^2 x| D8) acting on Omega x F_2 (18 points)
pts := [];; for x in [0..2] do for y in [0..2] do for e in [0,1] do Add(pts,[x,y,e]); od; od; od;
ix := t -> Position(pts, [t[1] mod 3, t[2] mod 3, t[3]]);;
mk := f -> PermList(List(pts, t -> ix(f(t))));;
flip := function(w) return mk(function(t) if t{[1,2]} = w then return [t[1],t[2],1-t[3]]; else return t; fi; end); end;;
gens := [ flip([0,0]),
  mk(t -> [t[1]+1,t[2],t[3]]), mk(t -> [t[1],t[2]+1,t[3]]),
  mk(t -> [-t[1],t[2],t[3]]), mk(t -> [t[2],t[1],t[3]]) ];;
G := Group(gens);; Print("|G| = ", Size(G), " expected 36864; soluble: ", IsSolvableGroup(G), "\n");
o := ix([0,0,0]);;
Zg := Group(flip([0,0]));; Hs := Group(gens[4], gens[5]);;
A := ClosureGroup(Zg, Hs);; B := Stabilizer(G, o);;
Print("|A|=",Size(A)," |B|=",Size(B)," nilpotent: ",IsNilpotentGroup(A), IsNilpotentGroup(B),"\n");
conjB := Set(List(RightTransversal(G, Normalizer(G,B)), g -> B^g));;
Print("number of conjugates of B: ", Length(conjB), "\n");
ints := [];; for XX in conjB do for YY in conjB do Add(ints, Intersection(A, XX, YY)); od; od;
Print("ordered pairs: ", Length(ints), "\n");
distinct := [];; for XX in ints do if not ForAny(distinct, DD -> DD = XX) then Add(distinct, XX); fi; od;
Print("distinct intersections: ", Length(distinct), " orders: ", Collected(List(distinct, Size)), "\n");
minincl := Filtered(distinct, XX -> not ForAny(distinct, YY -> Size(YY) < Size(XX) and IsSubgroup(XX,YY)));;
m := Minimum(List(distinct, Size));; minord := Filtered(distinct, XX -> Size(XX) = m);;
MinA := Group(Concatenation(List(minincl, GeneratorsOfGroup)), ());; minA := Group(Concatenation(List(minord, GeneratorsOfGroup)), ());;
FG := FittingSubgroup(G);;
Print("inclusion-minimal: ", Length(minincl), " minimum-order: ", Length(minord), " (order ", m, ")\n");
Print("Min = A: ", MinA = A, "  min = A: ", minA = A, "  |F(G)| = ", Size(FG), "  min <= F(G): ", IsSubgroup(FG, minA), "  Min <= F(G): ", IsSubgroup(FG, MinA), "\n");
QUIT;
