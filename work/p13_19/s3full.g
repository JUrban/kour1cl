MyIsRegular := function(P, p)
  local x, y, S, lhs;
  if IsAbelian(P) then return true; fi;
  if p = 2 then return false; fi;
  for x in P do for y in P do
    S := DerivedSubgroup(Group(x, y));
    lhs := (x*y)^p * (x^p * y^p)^-1;
    if not (lhs in Agemo(S, p, 1)) then return false; fi;
  od; od;
  return true;
end;
Search1319 := function(n)
  local k, Q, nsQ, H, P, p, cands, N, I, found;
  found := 0;
  for k in [1..NrSmallGroups(n)] do
    Q := SmallGroup(n, k);
    nsQ := NormalSubgroups(Q);
    for H in nsQ do
      if Size(H) = n or Size(H) = 1 then continue; fi;
      if not IsPrimePowerInt(Index(Q, H)) then continue; fi;
      p := PrimeDivisors(Index(Q,H))[1];
      P := Q / H;
      if IsAbelian(P) then continue; fi;
      if p > 2 and NilpotencyClassOfGroup(P) < p then continue; fi;  # class < p => regular
      cands := Filtered(nsQ, N -> Size(ClosureGroup(N, H)) = n);
      I := Q;
      for N in cands do I := Intersection(I, N); if Size(I) = 1 then break; fi; od;
      if Size(I) = 1 then
        if p = 2 or not MyIsRegular(P, p) then
          found := found + 1;
          Print("COUNTEREXAMPLE candidate: SmallGroup(", n, ",", k, ") ", StructureDescription(Q), " H of order ", Size(H), " Q/H = ", StructureDescription(P), " (class ", NilpotencyClassOfGroup(P), "), using ", Length(cands), " normal subgroups N\n");
        fi;
      fi;
    od;
  od;
  Print("done order ", n, " found ", found, "\n");
end;
Search1319(243); Search1319(729); Search1319(2187);
Print("FINISHED\n"); QUIT;
