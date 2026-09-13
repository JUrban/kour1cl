#define MAXN 16
/* 20.71 (Lauri/Pannone): connected graph with k isomorphism types of vertex-deleted cards and Aut(G) with more than k orbits, for k=2,3?
   Reads graph6 from stdin (geng -c n), computes number of Aut orbits and number of card types. */
#include "nauty.h"
#include "gtools.h"
#include <string.h>
#define MAXNN 16
static int card_types(graph *g, int n, int m){
  static graph h[MAXN*MAXM], canon[MAXN*MAXM]; static graph store[MAXN][MAXN*MAXM]; int nt=0;
  int lab[MAXN], ptn[MAXN], orbits[MAXN]; static DEFAULTOPTIONS_GRAPH(options); statsblk stats; options.getcanon=TRUE;
  for(int v=0; v<n; v++){
    /* build card: vertices != v, relabel */
    int map[MAXN]; int idx=0; for(int u=0;u<n;u++) if(u!=v) map[u]=idx++;
    EMPTYGRAPH(h, m, n-1);
    for(int u=0;u<n;u++) if(u!=v) for(int w=u+1;w<n;w++) if(w!=v && ISELEMENT(GRAPHROW(g,u,m),w)) ADDONEEDGE(h, map[u], map[w], m);
    densenauty(h, lab, ptn, orbits, &options, &stats, m, n-1, canon);
    int found=0; for(int t=0;t<nt && !found;t++) if(memcmp(store[t], canon, (size_t)m*(n-1)*sizeof(graph))==0) found=1;
    if(!found){ memcpy(store[nt], canon, (size_t)m*(n-1)*sizeof(graph)); nt++; }
  }
  return nt;
}
int main(int argc, char**argv){
  int n, m; static graph g[MAXN*MAXM]; char *line=NULL; size_t cap=0; long long cnt=0, hits=0;
  int lab[MAXN], ptn[MAXN], orbits[MAXN]; static DEFAULTOPTIONS_GRAPH(options); statsblk stats; options.getcanon=FALSE;
  while(getline(&line,&cap,stdin)>0){
    if(line[0]=='>') continue;
    n = graphsize(line); m = SETWORDSNEEDED(n); if(n>MAXN) continue; stringtograph(line, g, m);
    cnt++;
    densenauty(g, lab, ptn, orbits, &options, &stats, m, n, NULL);
    int no=0; for(int i=0;i<n;i++) if(orbits[i]==i) no++;
    if(no<=1) continue;
    int k = card_types(g, n, m);
    if(no > k && k <= 4){ hits++; printf("HIT k=%d orbits=%d graph6=%s", k, no, line); fflush(stdout); }
  }
  fprintf(stderr, "processed %lld graphs, hits %lld\n", cnt, hits); return 0; }
