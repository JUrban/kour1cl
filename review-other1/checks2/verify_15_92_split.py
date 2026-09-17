# Independent check of the prime split in 15.92, from the archive's own cycle receipt
# (results/15.92-cycle-controls.json produced by scripts/check_15_92_cycles.py at revision cff2c37).
import json, sys
d = json.load(open(sys.argv[1] if len(sys.argv) > 1 else '15.92-cycle-controls.json'))
rows = d['rows']; bad = 0; hp = {}
for r in rows:
    cyc = {int(k): v for k, v in r['cycle_structure'].items()}
    p, h = r['p'], r['h']; hp.setdefault(h, set()).add(p)
    E = 720720 // p
    ok = ([L for L in cyc if L % p == 0] == [p] and cyc[p] == 1
          and all(720720 % L == 0 for L in cyc)
          and all(E % L == 0 for L in cyc if L != p) and E % p != 0)
    if not ok: bad += 1; print("FAIL", h, r['d'], p, cyc)
print("rows:", len(rows), " passing:", len(rows) - bad)
print("prime used per h:", {h: sorted(v) for h, v in sorted(hp.items())})
print("max moved points:", max(r['moved_points'] for r in rows))
