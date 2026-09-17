# C.20 (18.18): common centraliser construction; C.40 (21.76): F9 group; E.1 (13.19): small subdirect example
cent := function(H, extra)
  local els, h, pts, a, b, n, G, C, k, N;
  els := AsSortedList(H);; h := Length(els);;
  pts := Cartesian([1..h],[0..h-1]);;
  a := PermList(List(pts, p -> Position(pts, [p[1], (p[2]+1) mod h])));;
  b := PermList(List(pts, p -> Position(pts, [Position(els, els[p[1]]*els[p[2]+1]), p[2]])));;
  n := h*h;;
  if extra then k := n + 3;; a := a * CycleFromList([n+1..n+k]);; b := b * (n+1,n+2);; N := n + k; else N := n; fi;
  G := Group(a, b);;
  C := Centralizer(SymmetricGroup(N), G);;
  return [N, IsTransitive(Group(a,b), [1..n]), Size(C), IdGroup(C) = IdGroup(H)];
end;;
for H in [CyclicGroup(IsPermGroup,4), SymmetricGroup(3), QuaternionGroup(IsPermGroup, 8)] do
  Print("H = ", StructureDescription(H), ": without extra orbit ", cent(H,false), "  with extra orbit ", cent(H,true), "\n");
od;
F := GF(9);; j := First(Elements(F), x -> x^2 = -One(F));;
G := Group([[1,1],[0,1]]*One(F), [[1,0],[j,1]]*One(F));;
Print("21.76: |<[[1,1],[0,1]],[[1,0],[j,1]]>| over F9 = ", Size(G), "\n");
U := Filtered(Elements(G), g -> g[1][1] = One(F) and g[2][2] = One(F) and IsZero(g[2][1]));;
L := Filtered(Elements(G), g -> g[1][1] = One(F) and g[2][2] = One(F) and IsZero(g[1][2]));;
Print("   upper parameters: ", Set(List(U, g->g[1][2])), "  lower parameters: ", Set(List(L, g->g[2][1])), "  (j = ", j, ")\n");
# E.1: D = UT3(F2), Q <= D^4 as described, H = kernel of phi
D := Group([[1,1,0],[0,1,0],[0,0,1]]*Z(2), [[1,0,0],[0,1,1],[0,0,1]]*Z(2));;
dd := function(a,b,c) return [[1,a,c],[0,1,b],[0,0,1]]*Z(2)^0; end;;
Q := [];;
for a1 in [0,1] do for a2 in [0,1] do for b1 in [0,1] do for b2 in [0,1] do for C in Tuples([0,1],4) do
  Add(Q, [dd(a1,b1,C[1]), dd(a1,b2,C[2]), dd(a2,b1,C[3]), dd(a2,b2,C[4])]);
od; od; od; od; od;
Print("13.19 example: |Q| = ", Length(Set(Q)), "  closed under multiplication: ",
  ForAll(Q, x -> ForAll(Q, y -> List([1..4], i -> x[i]*y[i]) in Q)), "\n");
QUIT;
