// find r vectors a_1..a_r in F2^m with (<row,a_1>,...,<row,a_r>) != 0 for every row of L (random search)
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static uint64_t s[2];
static inline uint64_t rnd(void){ uint64_t s1=s[0], s0=s[1]; s[0]=s0; s1^=s1<<23; s[1]=s1^s0^(s1>>18)^(s0>>5); return s[1]+s0; }
int main(int argc, char**argv){
  FILE*f=fopen(argv[1],"r"); int n,m; if(fscanf(f,"%d %d",&n,&m)!=2) return 1;
  uint64_t *L=malloc(n*sizeof(uint64_t)); char buf[256];
  for(int i=0;i<n;i++){ if(fscanf(f,"%s",buf)!=1) return 1; L[i]=0; for(int j=0;j<m;j++) if(buf[j]=='1') L[i]|=1ULL<<j; }
  long long trials = atoll(argv[2]); int r = atoi(argv[3]); s[0]=0x9E3779B97F4A7C15ULL ^ (argc>4? atoll(argv[4]):1); s[1]=0xBF58476D1CE4E5B9ULL;
  uint64_t mask = (m==64)?~0ULL:((1ULL<<m)-1); uint64_t a[8]; int found=0;
  for(long long t=0;t<trials;t++){
    for(int k=0;k<r;k++) a[k]=rnd()&mask;
    int ok=1;
    for(int i=0;i<n;i++){ int b=0; for(int k=0;k<r;k++) b|=__builtin_parityll(L[i]&a[k]); if(!b){ok=0;break;} }
    if(ok){ printf("FOUND after %lld trials:",t); for(int k=0;k<r;k++){ putchar(' '); for(int j=0;j<m;j++) putchar('0'+((a[k]>>j)&1)); } putchar('\n'); if(++found>=3) break; }
  }
  if(!found) printf("none in %lld trials\n",trials);
  return 0;
}
