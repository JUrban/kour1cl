// Exact cover by DLX (Knuth's dancing links) with node limit and random option ordering.
// input: m (columns) and then lines "k v1 v2 ... vk" (0-based vertices) for each option; output: chosen option indices or "NONE"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef struct { int L, R, U, D, C, row; } Node;
static Node *nd; static int *sz; static int ncol, nnodes; static long long limit, cnt; static int *sol, nsol;
static uint64_t s1 = 88172645463325252ULL; static inline uint64_t rnd(){ s1 ^= s1 << 13; s1 ^= s1 >> 7; s1 ^= s1 << 17; return s1; }
static void cover(int c){ nd[nd[c].R].L = nd[c].L; nd[nd[c].L].R = nd[c].R; for(int i = nd[c].D; i != c; i = nd[i].D) for(int j = nd[i].R; j != i; j = nd[j].R){ nd[nd[j].D].U = nd[j].U; nd[nd[j].U].D = nd[j].D; sz[nd[j].C]--; } }
static void uncover(int c){ for(int i = nd[c].U; i != c; i = nd[i].U) for(int j = nd[i].L; j != i; j = nd[j].L){ sz[nd[j].C]++; nd[nd[j].D].U = j; nd[nd[j].U].D = j; } nd[nd[c].R].L = c; nd[nd[c].L].R = c; }
static int search(int k){
  if(++cnt > limit) return -1;
  if(nd[0].R == 0){ nsol = k; return 1; }
  int c = -1, best = 1<<30;
  for(int j = nd[0].R; j != 0; j = nd[j].R) if(sz[j] < best){ best = sz[j]; c = j; if(best <= 1) break; }
  if(best == 0) return 0;
  cover(c);
  // collect rows and randomize order
  int rows[best]; int nr = 0; for(int r = nd[c].D; r != c; r = nd[r].D) rows[nr++] = r;
  for(int i = nr-1; i > 0; i--){ int j = rnd() % (i+1); int t = rows[i]; rows[i] = rows[j]; rows[j] = t; }
  for(int q = 0; q < nr; q++){ int r = rows[q]; sol[k] = nd[r].row;
    for(int j = nd[r].R; j != r; j = nd[j].R) cover(nd[j].C);
    int res = search(k+1);
    for(int j = nd[r].L; j != r; j = nd[j].L) uncover(nd[j].C);
    if(res != 0){ uncover(c); return res; }
  }
  uncover(c); return 0;
}
int main(int argc, char **argv){
  limit = atoll(argv[1]); s1 ^= (uint64_t)atoll(argv[2]) * 0x9E3779B97F4A7C15ULL;
  int m; if(scanf("%d", &m) != 1) return 1;
  int cap = 1 << 22; nd = malloc(sizeof(Node) * cap); sz = calloc(m + 1, sizeof(int));
  ncol = m; nnodes = m + 1;
  for(int j = 0; j <= m; j++){ nd[j].L = (j == 0) ? m : j - 1; nd[j].R = (j == m) ? 0 : j + 1; nd[j].U = nd[j].D = j; nd[j].C = j; nd[j].row = -1; }
  int k, row = 0, maxrows = 1 << 21; sol = malloc(sizeof(int) * (m + 1));
  while(scanf("%d", &k) == 1){
    int first = -1;
    for(int t = 0; t < k; t++){ int v; if(scanf("%d", &v) != 1) return 1; int c = v + 1; if(nnodes + 1 >= cap){ cap *= 2; nd = realloc(nd, sizeof(Node) * cap); }
      int id = nnodes++; nd[id].C = c; nd[id].row = row; nd[id].U = nd[c].U; nd[id].D = c; nd[nd[c].U].D = id; nd[c].U = id; sz[c]++;
      if(first < 0){ first = id; nd[id].L = nd[id].R = id; } else { nd[id].L = nd[first].L; nd[id].R = first; nd[nd[first].L].R = id; nd[first].L = id; } }
    row++;
  }
  cnt = 0; int res = search(0);
  if(res == 1){ for(int i = 0; i < nsol; i++) printf("%d ", sol[i]); printf("\n"); }
  else printf("NONE %s nodes=%lld\n", res < 0 ? "limit" : "unsat", cnt);
  return 0;
}
