# Absolute Chevalley commutator constants |C_{ij,rs}| for A2, B2, G2 computed from the adjoint representation
# convention: x_s(u)^-1 x_r(t)^-1 x_s(u) x_r(t) = prod_{i,j>0, increasing i+j} x_{ir+js}(C_{ij,rs} t^i u^j)
consts := function(type)
  local L, R, cb, pos, neg, roots, vecs, n, P, t, u, adm, X, rt, rtcoords, simple, Cart, shortIdx, coords, out, r, s, i, j, comm, rem, cand, q, c, deg, mono, e, k, res, pairs, idx, lens, B;
  L := SimpleLieAlgebra(type, 2, Rationals);; R := RootSystem(L);;
  cb := ChevalleyBasis(L);; B := Basis(L);;
  roots := Concatenation(PositiveRoots(R), NegativeRoots(R));;
  vecs := Concatenation(cb[1], cb[2]);;
  simple := SimpleSystem(R);;
  coords := List(roots, x -> SolutionMat(simple, x));;
  Cart := CartanMatrix(R);;
  # lengths: use symmetric bilinear form from BilinearFormMat
  lens := List(roots, x -> x*BilinearFormMat(R)*x);;
  P := PolynomialRing(Rationals, ["t","u"]);; t := IndeterminatesOfPolynomialRing(P)[1];; u := IndeterminatesOfPolynomialRing(P)[2];;
  n := Dimension(L);;
  adm := List(vecs, v -> AdjointMatrix(B, v));;
  X := function(idx, c) local M, A, k, res; A := adm[idx]*c; res := IdentityMat(n)*One(P); M := IdentityMat(n)*One(P);
       for k in [1..6] do M := M*A/k; if IsZero(M) then break; fi; res := res + M; od; return res; end;;
  out := [];
  for r in [1..Length(roots)] do for s in [1..Length(roots)] do
    if r <> s and roots[r] <> -roots[s] then
      comm := X(s,-u) * X(r,-t) * X(s,u) * X(r,t);;
      rem := comm;;
      pairs := Filtered(Cartesian([1..3],[1..3]), p -> p[1]*roots[r]+p[2]*roots[s] in roots);;
      SortBy(pairs, p -> p[1]+p[2]);;
      for e in pairs do
        idx := Position(roots, e[1]*roots[r]+e[2]*roots[s]);;
        # coefficient of t^i u^j in rem - I at the position of a nonzero entry of adm[idx]
        k := First(Cartesian([1..n],[1..n]), p -> adm[idx][p[1]][p[2]] <> 0);;
        mono := t^e[1]*u^e[2];;
        c := PolynomialCoefficientsOfPolynomial(rem[k[1]][k[2]] , t);;
        if Length(c) < e[1]+1 then c := 0; else
          c := PolynomialCoefficientsOfPolynomial(c[e[1]+1], u);;
          if Length(c) < e[2]+1 then c := 0; else c := Value(c[e[2]+1], [t,u], [0,0]); fi;
        fi;
        c := c / adm[idx][k[1]][k[2]];;
        Add(out, [coords[r], coords[s], e, coords[idx], AbsInt(c)]);
        rem := X(idx, -c*mono) * rem;;
      od;
      if not IsOne(rem) then Print("WARNING: peeling incomplete for ", coords[r], coords[s], "\n"); fi;
    fi;
  od; od;
  Print(type, ": simple roots squared lengths ", List(simple, x -> x*BilinearFormMat(R)*x), "\n");
  return out;
end;;
for ty in ["A","B","G"] do
  res := consts(ty);;
  PrintTo(Concatenation("chev_", ty, "2.txt"), res, "\n");
  Print(ty, "2: ", Length(res), " rule entries; distinct |C| values ", Set(List(res, x->x[5])), "\n");
od;
QUIT;
