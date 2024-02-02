#include "mex.h"
#include "iostream.h"
#include "stdlib.h"
typedef struct TR
{int fromvex,endvex;
float length;
}edge;

void prim1(double *out,double *len,double *op,int mrows,int ncols)
{edge *T;
 int j,k,m,v,max=9999;
 float d,min;
 edge e;
 T=(edge *)malloc((mrows-1)*sizeof(struct TR));
 for(j=1;j<mrows;j++)
 { (T+j-1)->fromvex=1;
  (T+j-1)->endvex=j+1;
  (T+j-1)->length=*(op+j);
}
 for(k=0;k<mrows-1;k++)
 { min=max;
   for(j=k;j<mrows-1;j++)
	 if((T+j)->length<min)
	 {min=(T+j)->length;
	  m=j;
	 }
   e=*(T+m);
   T[m]=*(T+k);
   *(T+k)=e;
   v=(T+k)->endvex;
for(j=k+1;j<mrows-1;j++)
 {d=*(op+(v-1)*ncols+(T+j)->endvex-1); 
 if(d<(T+j)->length)
  {(T+j)->length=d;
   (T+j)->fromvex=v;
  }
 }
  }
 *len=0;
 for(j=0;j<mrows-1;j++)
 {*(out+j*2)=(T+j)->fromvex;
  *(out+j*2+1)=(T+j)->endvex;
  *len=*len+(T+j)->length;
} 
}
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{double *op;
 double  *out;
 int mrows,ncols;
 double *len;
op=mxGetPr(prhs[0]);
  mrows=mxGetM(prhs[0]);
 ncols=mxGetN(prhs[0]);
  plhs[0]=mxCreateDoubleMatrix(2,ncols-1,mxREAL);
 plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 out=mxGetPr(plhs[0]);
 len=mxGetPr(plhs[1]);
 prim1(out,len,op,mrows,ncols);
}

