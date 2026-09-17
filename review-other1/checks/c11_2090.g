# C.11 (20.90): images of X=[[1,1],[0,1]], Y=[[0,1],[1,w+t]] in SL2(F4[t]/t^k), k=1,2,3
F := GF(4);; w := Z(4);;
# represent R_k = F4[t]/t^k by k x k matrices over F4 (companion of t), then 2x2 over R_k as 2k x 2k matrices
img := function(k)
  local T, I, Xm, Ym, blk, G;
  T := NullMat(k,k,F);; if k > 1 then T{[2..k]}{[1..k-1]} := IdentityMat(k-1,F); fi;
  I := IdentityMat(k,F);;
  blk := function(M) local R, i, j; R := NullMat(2*k,2*k,F);
    for i in [1..2] do for j in [1..2] do R{[(i-1)*k+1..i*k]}{[(j-1)*k+1..j*k]} := M[i][j]; od; od; return R; end;;
  Xm := blk([[I, I],[0*I, I]]);; Ym := blk([[0*I, I],[I, w*I+T]]);;
  G := Group(Xm, Ym);;
  return G;
end;;
for k in [1..3] do G := img(k);; Print("k=",k," |image| = ", Size(G), "  perfect: ", IsPerfectGroup(G), "  StructureDescription (k<=2): ", (function() if k<=2 then return StructureDescription(G); else return "-"; fi; end)(), "\n"); od;
# w satisfies w^2+w+1=0 in GF(4)
Print("w^2+w+1 = 0: ", IsZero(w^2+w+1), "\n");
QUIT;
