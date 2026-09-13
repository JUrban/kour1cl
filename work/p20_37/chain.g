# 20.37 (Hooshmand): |G| = ab  =>  G = AB with |A| = a, |B| = b ?
# Chain-achievable factor sizes: L(G) := closure under a -> |G|/a of  U_{M maximal} ( L(M) u |G:M|*L(M) ), L(1) = {1}.
# (G = T*M = M*T' with transversals; G = AB implies G = B^-1 A^-1.)  Every a in L(G) is realised by explicit subsets.
memo := NewDictionary(fail, true);
Lset := function(H)
  local key, res, M, LM, n, a, mx;
  n := Size(H);
  if n = 1 then return [1]; fi;
  key := fail;
  if n <= 2000 and not n in [512, 1024, 1536] then key := IdGroup(H); fi;
  if key <> fail then res := LookupDictionary(memo, key); if res <> fail then return res; fi; fi;
  res := [1, n];
  for M in MaximalSubgroupClassReps(H) do
    LM := Lset(M); mx := n / Size(M);
    for a in LM do AddSet(res, a); AddSet(res, mx * a); AddSet(res, n / a); AddSet(res, n / (mx * a)); od;
  od;
  if key <> fail then AddDictionary(memo, key, res); fi;
  return res;
end;
Missing := function(G) return Difference(DivisorsInt(Size(G)), Lset(G)); end;
