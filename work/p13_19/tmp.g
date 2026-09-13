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
