# Problem 21.113(a) (G. Robinson): Psi_{p,G}(x) = 0 if x p-singular, else = number of p-elements in C_G(x).
# Check whether Psi is a (proper) character for all small groups of order in [lo,hi].
IsPElt := function(g, p) return IsPrimePowerInt(Order(g)) and Order(g) mod p = 0 or Order(g)=1; end;
PsiCheck := function(G, p)
  local tbl, cls, reps, psi, i, x, C, cnt, irr, ip, chi, ok, bad;
  tbl := CharacterTable(G);
  cls := ConjugacyClasses(tbl);
  reps := List(cls, Representative);
  psi := [];
  for i in [1..Length(reps)] do
    x := reps[i];
    if Order(x) mod p = 0 then
      Add(psi, 0);
    else
      C := Centralizer(G, x);
      cnt := Number(C, y -> IsPElt(y,p));
      Add(psi, cnt);
    fi;
  od;
  irr := Irr(tbl);
  bad := [];
  for chi in irr do
    ip := ScalarProduct(tbl, psi, chi);
    if not (IsInt(ip) and ip >= 0) then Add(bad, ip); fi;
  od;
  return bad;
end;
