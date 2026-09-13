Print(LoadPackage("anupq"), "\n");
H := SmallGroup(128, 2150);
t := Runtime();
P := PqPCover(H);
Print("pcover order 2^", LogInt(Size(P), 2), " time ", Runtime() - t, " ms\n");
# epimorphism P -> H: PqPCover returns a pc group with an "epimorphism"? check attributes
Print(KnownAttributesOfObject(P), "\n");
QUIT;
