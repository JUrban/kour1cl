# 19.108 (Wilde): P a p-group, p odd, chi(x) <> 0  =>  o(x) | |P|/chi(1)^2 ?
CheckP := function(P, name)
  local tbl, irr, ords, chi, i, n, bad;
  tbl := CharacterTable(P); irr := Irr(tbl); ords := OrdersClassRepresentatives(tbl); n := Size(P); bad := false;
  for chi in irr do
    if chi[1] = 1 then continue; fi;
    for i in [1..Length(ords)] do
      if chi[i] <> 0 and (n / chi[1]^2) mod ords[i] <> 0 then
        Print("COUNTEREXAMPLE ", name, " chi(1)=", chi[1], " o(x)=", ords[i], " |P|=", n, "\n"); bad := true;
      fi;
    od;
  od;
  return bad;
end;
for n in [27, 81, 243, 729, 125, 625, 3125, 343, 2401, 2187] do
  for k in [1..NrSmallGroups(n)] do
    P := SmallGroup(n,k); if IsAbelian(P) then continue; fi;
    CheckP(P, Concatenation("SmallGroup(", String(n), ",", String(k), ")"));
    if k mod 2000 = 0 then Print("  ", n, " id ", k, "\n"); fi;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
