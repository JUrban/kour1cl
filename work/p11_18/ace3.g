LoadPackage("ace");
F := FreeGroup("x","y"); x := F.1; y := F.2;
LeftComm := function(u, v, k) local w, i; w := u; for i in [1..k] do w := Comm(w, v); od; return w; end;
rels := [x^-1 * LeftComm(x, y, 2), y^-1 * LeftComm(y, x, 3)];
Print("ACE big run: workspace 4G words, max 400M, hard strategy\n");
t := ACECosetTableFromGensAndRels([x,y], rels, [] : workspace := "4G", max := 400000000, hard);
if t = fail then Print("ACE: FAILED\n"); else Print("ACE: ORDER ", Length(t[1]), "\n"); fi;
QUIT;
