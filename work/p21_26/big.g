Read("/project/work/p21_26/check.g");
grps := [ [SymmetricGroup(7),"S7"], [SymmetricGroup(8),"S8"], [AlternatingGroup(8),"A8"], [MathieuGroup(11),"M11"], [MathieuGroup(12),"M12"], [PSL(3,3),"L3(3)"], [PSU(3,3),"U3(3)"], [PGL(2,7),"PGL(2,7)"], [PGL(2,9),"PGL(2,9)"], [PGL(2,11),"PGL(2,11)"], [PSL(2,16),"L2(16)"], [PSL(2,17),"L2(17)"], [PSL(2,19),"L2(19)"], [PSL(2,23),"L2(23)"], [PSL(2,25),"L2(25)"], [PSL(2,27),"L2(27)"], [PSL(2,29),"L2(29)"], [PSL(2,31),"L2(31)"], [PSL(2,32),"L2(32)"], [SymmetricGroup(9),"S9"], [PSL(3,4),"L3(4)"], [PSU(4,2),"U4(2)"], [WreathProduct(SymmetricGroup(3),SymmetricGroup(3)),"S3wrS3"], [WreathProduct(SymmetricGroup(4),SymmetricGroup(3)),"S4wrS3"], [WreathProduct(AlternatingGroup(5),CyclicGroup(IsPermGroup,2)),"A5wrC2"], [WreathProduct(SymmetricGroup(3),SymmetricGroup(4)),"S3wrS4"], [PerfectGroup(IsPermGroup,960,1),"2^4:A5"], [PerfectGroup(IsPermGroup,1344,1),"2^3.L3(2)"], [SL(2,5),"SL(2,5)"], [GL(2,5),"GL(2,5)"], [GL(3,3),"GL(3,3)"], [SymmetricGroup(10),"S10"] ];
for pr in grps do
  G := pr[1];
  Print(pr[2], " |G|=", Size(G), " ok=", Check2126(G), "\n");
od;
Print("FINISHED\n"); QUIT;
