# verify a solution file: sol_<n>.txt lines: "a b", then A as perms, then B as perms; checks |A*B| = |G| and A,B subset G
VerifySol := function(G, fname)
  local lines, i, a, b, A, B, prods, ok;
  lines := SplitString(StringFile(fname), "\n");
  lines := Filtered(lines, l -> l <> "");
  i := 1; ok := true;
  while i + 2 <= Length(lines) do
    a := Int(SplitString(lines[i], " ")[1]); b := Int(SplitString(lines[i], " ")[2]);
    A := List(SplitString(lines[i+1], " "), s -> PermList(List(SplitString(s, ","), Int) + 1));
    B := List(SplitString(lines[i+2], " "), s -> PermList(List(SplitString(s, ","), Int) + 1));
    prods := Set(List(Cartesian(A, B), p -> p[1]*p[2]));
    if Length(A) = a and Length(B) = b and a*b = Size(G) and ForAll(A, x -> x in G) and ForAll(B, x -> x in G) and Length(prods) = Size(G) then
      Print("  verified: |G|=", Size(G), " = ", a, " * ", b, " (G = AB, all products distinct)\n");
    else
      Print("  FAILED for a=", a, " b=", b, "\n"); ok := false;
    fi;
    i := i + 3;
  od;
  return ok;
end;
