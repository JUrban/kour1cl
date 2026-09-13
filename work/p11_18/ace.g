LoadPackage("ace");
F := FreeGroup("x","y"); x := F.1; y := F.2;
LeftComm := function(u, v, k) local w, i; w := u; for i in [1..k] do w := Comm(w, v); od; return w; end;
rels := [x^-1 * LeftComm(x, y, 2), y^-1 * LeftComm(y, x, 3)];
Print("ACE coset enumeration of G(2,3) over trivial subgroup, max 3e8 cosets\n");
t := ACECosetTableFromGensAndRels([x,y], rels, [] : max := 300000000, workspace := 4000000000, hard, silent);
if t = fail then Print("ACE: FAILED (no result)\n"); else Print("ACE: order ", Length(t[1]), "\n"); fi;
QUIT;
