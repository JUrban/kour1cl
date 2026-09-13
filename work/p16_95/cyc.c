// 16.95 (Thompson): for every A in GL(n,q) is there a permutation matrix P with AP cyclic?
// Exhaustive check for prime q (small n). A matrix M is cyclic iff I, M, ..., M^{n-1} are linearly independent.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int n, q;
int perms[720][8]; int nperms;
static int inv[64];
void genperms(){ int p[8]; for(int i=0;i<n;i++) p[i]=i; nperms=0;
  // Heap's algorithm iterative
  int c[8]={0}; memcpy(perms[nperms++],p,sizeof(int)*n); int i=0;
  while(i<n){ if(c[i]<i){ if(i%2==0){int t=p[0];p[0]=p[i];p[i]=t;} else {int t=p[c[i]];p[c[i]]=p[i];p[i]=t;} memcpy(perms[nperms++],p,sizeof(int)*n); c[i]++; i=0;} else {c[i]=0;i++;} } }
int rankmod(int *rows, int nr, int nc){ // rows: nr x nc, mod q, destroys
  int r=0; for(int c=0;c<nc && r<nr;c++){ int piv=-1; for(int i=r;i<nr;i++) if(rows[i*nc+c]%q){piv=i;break;} if(piv<0) continue;
    if(piv!=r){ for(int j=0;j<nc;j++){int t=rows[piv*nc+j];rows[piv*nc+j]=rows[r*nc+j];rows[r*nc+j]=t;} }
    int iv=inv[rows[r*nc+c]%q]; for(int j=0;j<nc;j++) rows[r*nc+j]=(rows[r*nc+j]*iv)%q;
    for(int i=0;i<nr;i++) if(i!=r && rows[i*nc+c]%q){ int f=rows[i*nc+c]; for(int j=0;j<nc;j++) rows[i*nc+j]=((rows[i*nc+j]-f*rows[r*nc+j])%q+q)%q; }
    r++; } return r; }
int iscyclic(int *M){ // M n x n
  int pw[8][64]; int rows[8*64]; // powers
  for(int i=0;i<n*n;i++) pw[0][i]=(i%(n+1)==0); // identity
  for(int k=1;k<n;k++){ for(int i=0;i<n;i++) for(int j=0;j<n;j++){ int s=0; for(int l=0;l<n;l++) s+=pw[k-1][i*n+l]*M[l*n+j]; pw[k][i*n+j]=s%q; } }
  for(int k=0;k<n;k++) for(int i=0;i<n*n;i++) rows[k*n*n+i]=pw[k][i];
  return rankmod(rows,n,n*n)==n; }
int det(int *M){ int A[64]; memcpy(A,M,sizeof(int)*n*n); int d=1; for(int c=0;c<n;c++){ int piv=-1; for(int i=c;i<n;i++) if(A[i*n+c]%q){piv=i;break;} if(piv<0) return 0; if(piv!=c){ for(int j=0;j<n;j++){int t=A[piv*n+j];A[piv*n+j]=A[c*n+j];A[c*n+j]=t;} d=(q-d)%q; } d=(d*A[c*n+c])%q; int iv=inv[A[c*n+c]%q]; for(int i=c+1;i<n;i++){ int f=(A[i*n+c]*iv)%q; for(int j=0;j<n;j++) A[i*n+j]=((A[i*n+j]-f*A[c*n+j])%q+q)%q; } } return d; }
int main(int argc,char**argv){ n=atoi(argv[1]); q=atoi(argv[2]); for(int a=1;a<q;a++) for(int b=1;b<q;b++) if((a*b)%q==1) inv[a]=b; genperms();
  long long total=0, bad=0; int M[64]; long long N=1; for(int i=0;i<n*n;i++) N*=q;
  for(long long code=0; code<N; code++){ long long c=code; for(int i=0;i<n*n;i++){ M[i]=c%q; c/=q; } if(!det(M)) continue; total++;
    int ok=0; for(int pi=0;pi<nperms && !ok;pi++){ int MP[64]; // (A P)_{ij} = sum_l A_{il} P_{lj}, P_{lj}=1 iff j=perm[l]
      for(int i=0;i<n;i++) for(int j=0;j<n;j++) MP[i*n+j]=0; for(int i=0;i<n;i++) for(int l=0;l<n;l++) MP[i*n+perms[pi][l]]=M[i*n+l];
      if(iscyclic(MP)) ok=1; }
    if(!ok){ bad++; if(bad<=5){ printf("COUNTEREXAMPLE n=%d q=%d A=",n,q); for(int i=0;i<n*n;i++) printf("%d",M[i]); printf("\n"); } } }
  printf("n=%d q=%d: |GL|=%lld, matrices with no cyclic AP: %lld\n",n,q,total,bad); return 0; }
