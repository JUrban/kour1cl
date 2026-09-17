# C.1 (21.121(a)): check claim (2) for all subgroups of G_k, k=1,2 (n=2^k-1)
S := SL(2,3);; S := Image(IsomorphismPermGroup(S));;
test := function(k)
  local n, D, emb, Zs, code, a, v, N, G, P, cls, H, u, m, s, ok, bad, zS, O, cnt, cand, i, gens;
  n := 2^k-1;
  D := DirectProduct(List([1..n], i->S));;
  zS := First(Centre(S), x -> Order(x)=2);;
  Zs := List([1..n], i -> Image(Embedding(D,i), zS));;
  # simplex code: coordinates indexed by nonzero v in F_2^k
  v := Filtered(Tuples([0,1],k), t -> t <> List([1..k],i->0));;
  code := List(IdentityMat(k), a -> Product([1..n], i -> Zs[i]^(a*v[i] mod 2)));;
  N := Subgroup(D, code);;
  G := D / N;;  G := Image(IsomorphismPermGroup(G));;
  Print("k=",k," |G_k|=",Size(G)," expected ", 24^n/2^k, "\n");
  P := PCore(G,2);; Print("  |P_k|=",Size(P)," O_{2'}(G_k) trivial: ", Size(Core(G, HallSubgroup(G,[3]))) = 1 and Size(PCore(G,3))=1, "\n");
  cls := ConjugacyClassesSubgroups(G);; bad := 0; cnt := 0;
  for O in cls do
    H := Representative(O); cnt := cnt+1;
    u := Size(SylowSubgroup(H,2));
    # largest normal abelian subgroup of odd order: search normal subgroups of the Hall 2'-part
    cand := Filtered(NormalSubgroups(H), X -> IsAbelian(X) and IsOddInt(Size(X)));;
    m := Minimum(List(cand, X -> Index(H,X)));;
    s := Log(m/u, 3);;
    if 3^s <> m/u then Print("  non-3-power ratio!\n"); bad := bad+1; fi;
    if not (u*(s+1) >= 8^s) then bad := bad+1; Print("  violation: |H|=",Size(H)," u=",u," s=",s,"\n"); fi;
  od;
  Print("  classes checked: ", cnt, "  violations: ", bad, "\n");
end;;
test(1);; test(2);;
QUIT;
