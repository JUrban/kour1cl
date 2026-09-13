// find 3 vectors a1,a2,a3 in F2^m such that for every row r in L: (<r,a1>,<r,a2>,<r,a3>) != 0
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
static uint64_t s[2];
static inline uint64_t rnd(void){ uint64_t s1=s[0], s0=s[1]; s[0]=s0; s1^=s1<<23; s[1]=s1^s0^(s1>>18)^(s0>>5); return s[1]+s0; }
int main(int argc, char**argv){
  FILE*f=fopen(argv[1],"r"); int n,m; fscanf(f,"%d %d",&n,&m);
  uint64_t *L=malloc(n*sizeof(uint64_t)); char buf[256];
  for(int i=0;i<n;i++){ fscanf(f,"%s",buf); L[i]=0; for(int j=0;j<m;j++) if(buf[j]=='1') L[i]|=1ULL<<j; }
  long long trials = atoll(argv[2]); s[0]=0x9E3779B97F4A7C15ULL ^ (argc>3? atoll(argv[3]):1); s[1]=0xBF58476D1CE4E5B9ULL;
  uint64_t mask = (m==64)?~0ULL:((1ULL<<m)-1);
  int found=0;
  for(long long t=0;t<trials;t++){
    uint64_t a1=rnd()&mask, a2=rnd()&mask, a3=rnd()&mask; int ok=1;
    for(int i=0;i<n;i++){ int b=(__builtin_parityll(L[i]&a1))|(__builtin_parityll(L[i]&a2)<<1)|(__builtin_parityll(L[i]&a3)<<2); if(!b){ok=0;break;} }
    if(ok){ printf("FOUND after %lld trials: ",t); for(int j=0;j<m;j++) putchar('0'+((a1>>j)&1)); putchar(' '); for(int j=0;j<m;j++) putchar('0'+((a2>>j)&1)); putchar(' '); for(int j=0;j<m;j++) putchar('0'+((a3>>j)&1)); putchar('\n'); found++; if(found>=5) break; }
  }
  if(!found) printf("none in %lld trials\n",trials);
  return 0;
}
