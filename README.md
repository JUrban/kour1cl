# Kourovka Notebook (21st ed., 2026) — attack on open problems

Started: 2026-09-13 08:03 UTC. Hard deadline: 2026-09-15 08:03 UTC (48 h).

Layout:
- `docs/` — the notebook (pdf + pdftotext dump).
- `plans/` — planning documents, candidate lists, triage.
- `work/<problem>/` — per-problem scripts (GAP/Python), data, logs.
- `reports/` — write-ups of solutions (one file per solved / partially solved problem),
  plus `PROGRESS.md` (running log).

Resource limits: ≤ 20 CPU cores, ≤ 100 GB RAM.

## Where to look
- `reports/README.md` — index of results: five problems solved (21.32, 16.60, 2.78/3.57, 18.46, 13.19), substantial
  partial results (16.14, 20.21, 20.37, 19.56, 21.26, 21.111, 18.117) and a table of bounded-range verifications
  (`reports/verifications.md`).
- Every report names the scripts and logs in `work/p<problem>/` that reproduce the computation (GAP 4.16.1 with
  the SmallGroups, TransitiveGroups, PrimitiveGroups, CTblLib, AtlasRep, ANUPQ and Digraphs packages; nauty 2.8.6;
  Python 3.12 with networkx and python-sat in `venv/`).
- `reports/PROGRESS.md` is the chronological log (timestamps are UTC; the entries of the first afternoon were
  corrected from the git history).
- `paper/main.pdf` (sources in `paper/`) — an arXiv-style write-up of the experiment and its results, written
  after the 48 hours; compile with Tectonic (`paper/bin/tectonic main.tex`) or any LaTeX with the standard packages.
