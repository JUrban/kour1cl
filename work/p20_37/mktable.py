# build the results table for the report from f4log_*.txt / solb_*.txt and caseb_*.txt
import glob, re, os
rows = []
for cf in sorted(glob.glob('caseb_*.txt'), key=lambda f: int(re.findall(r'\d+', f)[0])):
    n = int(re.findall(r'\d+', cf)[0])
    with open(cf) as f: f.readline(); need = list(map(int, f.readline().split()))
    found = {}
    for lf in ['f4log_%d.txt' % n, 'f5log_%d.txt' % n]:
      if not os.path.exists(lf): continue
      if True:
        for l in open(lf):
            m = re.match(r'FOUND \|G\|=(\d+) a=(\d+) b=(\d+) via \|H\|=(\d+) k=(\d+) \|K\|=(\d+) l=(\d+) \|Omega\|=(\d+)', l)
            if m: found[int(m.group(2))] = (int(m.group(4)), int(m.group(5)), int(m.group(6)), int(m.group(7)), int(m.group(8)))
    nsol = 0
    for sf in ['solb_%d.txt' % n, 'sol_%d.txt' % n]:
      if os.path.exists(sf):
        for i, l in enumerate(open(sf)):
            if i % 3 == 0 and l.strip():
                aa = int(l.split()[0]); aa = min(aa, n // aa)
                if aa not in found: nsol += 1; found[aa] = (0, 0, 0, 0, 0)
    rows.append((n, need, found, nsol))
print("| |G| | missing sizes a (a ≤ |G|/a) | realised | construction data (a: |H|, k, |K|, l, |Ω|) |")
print("|---|---|---|---|")
tot_need = tot_found = 0
for n, need, found, nsol in rows:
    tot_need += len(need); tot_found += len([a for a in need if a in found])
    data = "; ".join("%d: %d,%d,%d,%d,%d" % ((a,) + found[a]) for a in need if a in found)
    miss = [a for a in need if a not in found]
    print("| %d | %s | %d/%d%s | %s |" % (n, ", ".join(map(str, need)), len(need) - len(miss), len(need), (" (open: %s)" % ", ".join(map(str, miss))) if miss else "", data))
print("\nTotal: %d of %d missing sizes realised." % (tot_found, tot_need))
