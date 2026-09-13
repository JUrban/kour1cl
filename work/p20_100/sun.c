// 20.100 n=4: for every 4-subset A of G, is there an ordering a1,a2,a3,a4 with a1, a2^2, a3^3, a4^4 pairwise distinct?
#include <stdio.h>
#include <stdlib.h>
int n; int *T; int mul(int a,int b){return T[a*n+b];}
int pw(int a,int k){int r=a; for(int i=1;i<k;i++) r=mul(r,a); return r;}
int main(int argc,char**argv){ FILE*f=fopen(argv[1],"r"); if(fscanf(f,"%d",&n)!=1) return 1; T=malloc(sizeof(int)*n*n);
  for(int i=0;i<n*n;i++){ int v; if(fscanf(f,"%d",&v)!=1) return 1; T[i]=v-1; }
  int *p2=malloc(sizeof(int)*n),*p3=malloc(sizeof(int)*n),*p4=malloc(sizeof(int)*n);
  for(int a=0;a<n;a++){p2[a]=pw(a,2);p3[a]=pw(a,3);p4[a]=pw(a,4);}
  int perm[24][4]={{0,1,2,3},{0,1,3,2},{0,2,1,3},{0,2,3,1},{0,3,1,2},{0,3,2,1},{1,0,2,3},{1,0,3,2},{1,2,0,3},{1,2,3,0},{1,3,0,2},{1,3,2,0},{2,0,1,3},{2,0,3,1},{2,1,0,3},{2,1,3,0},{2,3,0,1},{2,3,1,0},{3,0,1,2},{3,0,2,1},{3,1,0,2},{3,1,2,0},{3,2,0,1},{3,2,1,0}};
  long long bad=0, tot=0;
  for(int a=0;a<n;a++)for(int b=a+1;b<n;b++)for(int c=b+1;c<n;c++)for(int d=c+1;d<n;d++){ int A[4]={a,b,c,d}; int ok=0; tot++;
    for(int q=0;q<24&&!ok;q++){ int x1=A[perm[q][0]], x2=p2[A[perm[q][1]]], x3=p3[A[perm[q][2]]], x4=p4[A[perm[q][3]]];
      if(x1!=x2&&x1!=x3&&x1!=x4&&x2!=x3&&x2!=x4&&x3!=x4) ok=1; }
    if(!ok){ bad++; if(bad<=3) printf("COUNTEREXAMPLE %s: subset {%d,%d,%d,%d}\n",argv[1],a+1,b+1,c+1,d+1); } }
  printf("%s: n=%d subsets=%lld bad=%lld\n",argv[1],n,tot,bad); return 0; }
