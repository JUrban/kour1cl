import json, sys, re
import numpy as np
from scipy.optimize import linprog
txt = open('/project/work/p21_113/lp_data.jsonl').read()
chunks = [c for c in txt.split('{"group"') if c.strip()]
bad = 0; total = 0
for c in chunks:
    s = '{"group"' + c
    s = re.sub(r'"group": "\[ ([0-9]+), ([0-9]+) \]"', r'"group": "\1_\2"', s)
    s = s.replace('\n', ' ')
    try:
        d = json.loads(s)
    except Exception as e:
        print("parse error", s[:80]); continue
    psi = np.array(d['psi'], dtype=float)
    A = np.array(d['perm'], dtype=float).T
    total += 1
    res = linprog(c=np.zeros(A.shape[1]), A_eq=A, b_eq=psi, bounds=[(0,None)]*A.shape[1], method='highs')
    if res.status != 0:
        bad += 1
        print("INFEASIBLE:", d['group'], "p=", d['p'])
print("total", total, "infeasible", bad)
