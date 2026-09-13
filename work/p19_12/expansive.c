// 19.12: check conjugacy-expansiveness: for every nonempty subset N of classes and every class C, |N C| >= |N| (as sets of classes)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char**argv){ FILE*f=fopen(argv[1],"r"); char name[200]; int n; fscanf(f,"%s %d",name,&n);
  static unsigned int M[24][24]; for(int t=0;t<n*n;t++){ int i,j; char buf[4096]; fscanf(f,"%d %d %s",&i,&j,buf); unsigned int m=0; char*p=strtok(buf,","); while(p){ m|=1u<<(atoi(p)-1); p=strtok(NULL,","); } M[i-1][j-1]=m; }
  long long bad=0; unsigned int full=(n==32)?0xffffffffu:((1u<<n)-1);
  for(unsigned int N=1; N<=full; N++){ int cN=__builtin_popcount(N); for(int j=0;j<n;j++){ unsigned int NC=0; for(int i=0;i<n;i++) if(N>>i&1) NC|=M[i][j]; if(__builtin_popcount(NC)<cN){ if(bad<3) printf("VIOLATION %s N=%x C=%d |N|=%d |NC|=%d\n",name,N,j+1,cN,__builtin_popcount(NC)); bad++; } } }
  printf("%s: n=%d violations=%lld\n",name,n,bad); return 0; }
