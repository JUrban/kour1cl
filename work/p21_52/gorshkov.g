LoadPackage("digraphs");
# Problems 21.52 / 21.53 (Gorshkov). L simple, D a class of involutions, Gamma = complete graph on D,
# edge colour of {a,b} = |ab|. Aut(Gamma) = colour-preserving permutations of D.
# 21.52: is Aut(Gamma) <= Aut(L) (i.e. equal to the image of Stab_{Aut L}(D)) ?
# 21.53: is Aut(Gamma) = Aut_2(Gamma) meet Aut_p(Gamma), p the second smallest prime divisor of |L| ?
ColouredGraphData := function(L, D)
  local elts, n, i, j, nb, ec, o, ords, dg;
  elts := AsList(D);   # D is a conjugacy class of involutions
  n := Length(elts);
  nb := List([1..n], i -> Filtered([1..n], j -> j <> i));
  ec := List([1..n], i -> List(nb[i], j -> Order(elts[i]*elts[j])));
  ords := Set(Concatenation(ec));
  ec := List(ec, l -> List(l, x -> Position(ords, x)));
  dg := Digraph(nb);
  return rec(elts := elts, n := n, dg := dg, ec := ec, ords := ords);
end;
AutColoured := function(data)
  return AutomorphismGroup(data.dg, List([1..data.n], i -> 1), data.ec);
end;
AutSingleColour := function(data, t)
  # permutations preserving the relation |ab| = t (as a graph)
  local nb, i, dg;
  nb := List([1..data.n], i -> Filtered([1..data.n], j -> j <> i and data.ords[data.ec[i][Position(OutNeighbours(data.dg)[i], j)]] = t));
  dg := Digraph(nb);
  return AutomorphismGroup(dg);
end;
Analyse := function(L, name)
  local A, cls, D, data, G, stabD, hom, img, ordsA, primes, p, A2, Ap, I, res, orders, imgsize;
  A := AutomorphismGroup(L);
  cls := Filtered(ConjugacyClasses(L), c -> Order(Representative(c)) = 2);
  primes := PrimeDivisors(Size(L));
  p := primes[2];
  for D in cls do
    data := ColouredGraphData(L, D);
    G := AutColoured(data);
    # image of Stab_{Aut L}(D) in Sym(D): Aut(L) acts faithfully on D
    stabD := Stabilizer(A, Set(AsList(D)), OnSets);
    imgsize := Size(stabD);
    A2 := AutSingleColour(data, 2);
    Ap := AutSingleColour(data, p);
    I := Intersection(A2, Ap);
    Print(name, " |D|=", data.n, " |Aut(Gamma)|=", Size(G), " |Stab_{Aut L}(D)|=", imgsize,
          "  [21.52 ", Size(G) = imgsize, "]   |Aut_2|=", Size(A2), " |Aut_", p, "|=", Size(Ap),
          " |Aut_2 meet Aut_p|=", Size(I), "  [21.53 ", Size(I) = Size(G), "]\n");
  od;
end;
