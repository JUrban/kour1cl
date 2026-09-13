# Fast filters for a candidate quotient H = G/E (r = rank E) via the p-covering group P*(H) = F/R^2[F,R] (ANUPQ):
#  (F2) every maximal subgroup M of H has Phi(M) = Phi(H);
#  (F3') some involution h of H lifts to an involution in P*(H)  [equivalent to (F3): l_h = 0 on all cocycles].
LoadPackage("anupq");;
SetInfoLevel(InfoANUPQ, 0);
F2 := function(H)
  local PhiH;
  PhiH := FrattiniSubgroup(H);
  return ForAll(MaximalSubgroups(H), M -> FrattiniSubgroup(M) = PhiH);
end;
# lift of h in P*: same exponent vector on the first n generators (pq extends the pc presentation of H)
LiftMap := function(H, P)
  local n, pcH, pcP;
  pcH := Pcgs(H); pcP := Pcgs(P); n := Length(pcH);
  return h -> PcElementByExponents(pcP, Concatenation(ExponentsOfPcElement(pcH, h), ListWithIdenticalEntries(Length(pcP) - n, 0)));
end;
CheckLift := function(H, P)   # sanity: the lift map induces a homomorphism P -> H (kills the new generators)
  local pcH, pcP, n, hom;
  pcH := Pcgs(H); pcP := Pcgs(P); n := Length(pcH);
  hom := GroupHomomorphismByImages(P, H, List(pcP), Concatenation(List(pcH), ListWithIdenticalEntries(Length(pcP) - n, One(H))));
  return hom <> fail;
end;
F3prime := function(H)   # returns true if some involution lifts to an involution in P*(H)
  local P, lift, Z, cand, h, invs;
  P := PqPCover(H);
  lift := LiftMap(H, P);
  # first the central involutions in Phi(H), then all involutions
  cand := Filtered(Elements(Intersection(Centre(H), FrattiniSubgroup(H))), x -> Order(x) = 2);
  for h in cand do if IsOne(lift(h)^2) then return true; fi; od;
  invs := Filtered(Elements(H), x -> Order(x) = 2);
  for h in invs do if IsOne(lift(h)^2) then return true; fi; od;
  return false;
end;
AnalyseFast := function(n, k, r, tag, sanity)
  local H, P;
  H := SmallGroup(n, k);
  if RankPGroup(H) <> 2*r+1 then return "rank"; fi;
  if sanity then P := PqPCover(H); if not CheckLift(H, P) then Print(tag, " ", [n,k], " LIFT MAP NOT A HOMOMORPHISM\n"); return "BAD"; fi; fi;
  if F3prime(H) then return "F3"; fi;
  if not F2(H) then return "F2"; fi;
  Print(tag, " ", [n,k], " SURVIVOR (passes F3' and F2)\n");
  return "S";
end;
