# 16.45 (Cameron): b(G) = max size of an irredundant family of subgroups with trivial intersection;
# mu'(G) = max size of an independent set of elements. Is b(G) = mu'(G)?
MuPrime := function(G)
  local elts, best, rec_, n;
  elts := Filtered(Elements(G), x -> not IsOne(x));
  best := 0;
  rec_ := function(chosen, start)
    local i, x, ok, j, S;
    if Length(chosen) > best then best := Length(chosen); fi;
    for i in [start..Length(elts)] do
      x := elts[i];
      # independence: x not in <chosen>, and no chosen element in <chosen minus it, x>
      if x in Subgroup(G, chosen) then continue; fi;
      ok := true;
      for j in [1..Length(chosen)] do
        S := Subgroup(G, Concatenation(chosen{Difference([1..Length(chosen)],[j])}, [x]));
        if chosen[j] in S then ok := false; break; fi;
      od;
      if ok then rec_(Concatenation(chosen, [x]), i+1); fi;
    od;
  end;
  rec_([], 1);
  return best;
end;
BOfG := function(G)
  local subs, best, rec_;
  subs := Filtered(Concatenation(List(ConjugacyClassesSubgroups(G), c -> AsList(c))), S -> Size(S) > 1 and Size(S) < Size(G));
  best := 0;
  rec_ := function(chosen, inter, start)
    local i, S, ni, ok, j, I;
    if Size(inter) = 1 then
      # irredundancy
      ok := true;
      for j in [1..Length(chosen)] do
        I := G; for i in Difference([1..Length(chosen)],[j]) do I := Intersection(I, chosen[i]); od;
        if Size(I) = 1 then ok := false; break; fi;
      od;
      if ok and Length(chosen) > best then best := Length(chosen); fi;
      return;
    fi;
    for i in [start..Length(subs)] do
      S := subs[i]; ni := Intersection(inter, S);
      if Size(ni) = Size(inter) then continue; fi;
      rec_(Concatenation(chosen, [S]), ni, i+1);
    od;
  end;
  rec_([], G, 1);
  return best;
end;
for n in [2..32] do
  for k in [1..NrSmallGroups(n)] do
    G := SmallGroup(n,k); if IsCyclic(G) then continue; fi;
    b := BOfG(G); m := MuPrime(G);
    if b <> m then Print("MISMATCH ", [n,k], " ", StructureDescription(G), " b=", b, " mu'=", m, "\n"); fi;
  od;
  Print("done order ", n, "\n");
od;
Print("FINISHED\n"); QUIT;
