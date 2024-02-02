#include "mex.h"
#include "iostream.h"
#include "stdlib.h"
#include "stdio.h"
#define INFINITY  10000
void dijkstra(double *g,int u1 ,int u2,double *out,double *value,int mrows,int ncols)
{double *p,*d,*final;
 int i,v,min,j,w,count,judge=1;
 p=(double *)malloc(sizeof(double)*mrows*ncols);
 d=(double *)malloc(sizeof(double)*mrows);	
 final=(double *)malloc(sizeof(double)*mrows); 
 for(i=0;i<ncols;i++)
 {if(*(g+u1-1+i*mrows)==INFINITY)
 judge=0;     
 else {judge=1;break;}
 }
 if(judge==1){
 for(v=0;v<mrows;++v)
 {*(final+v)=0;*(d+v)=*(g+u1-1+v*mrows);
 for(w=0;w<mrows;++w)
 *(p+v+w*mrows)=0;
 *(p+v+v*mrows)=1;
 if(*(d+v)<INFINITY)
 {*(p+v+(u1-1)*mrows)=1;}
 }
 *(d+u1-1)=0;*(final+u1-1)=1;
 for(i=0;i<mrows-1;++i)
 {min=INFINITY;
 for(w=0;w<mrows;++w)
 if(!*(final+w))
 if(*(d+w)<min)
 {v=w;min=*(d+w);}
 *(final+v)=1;
 for(w=0;w<mrows;++w)
 if((!*(final+w))&&(min+*(g+v+mrows*w)<*(d+w)))
 {*(d+w)=min+*(g+v+mrows*w);
 for(j=0;j<mrows;++j)
 if(*(p+v+j*mrows)==1)
 *(p+w+j*mrows)=1;
 *(p+w+v*mrows)=1;
  }
 }
 count=0;*out=u1;
 for(j=0;j<mrows;++j)
 if(*(p+u2-1+j*mrows)==1)
 {count=count+1;
 if(((j+1)!=u1)&&((j+1)!=u2))  *(out+count)=j+1;
 else count=count-1;
 }
  if(*(d+u2-1)!=INFINITY)
 *value=*(d+u2-1);
 else *value=0;
 if(*value!=0) *(out+count+1)=u2;
  }
 else{
 for(j=0;j<mrows;++j)
 *(out+j)=0;
 *value=0;
 }
 free(p);free(d);free(final);
}
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{double *out,*value;
 double *g;
 int u1,u2;
 int mrows,ncols;
 u1=mxGetScalar(prhs[1]); 
 u2=mxGetScalar(prhs[2]);
 g=mxGetPr(prhs[0]);
 mrows=mxGetM(prhs[0]);
 ncols=mxGetN(prhs[0]);
 plhs[0]=mxCreateDoubleMatrix(1,ncols,mxREAL);
 plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 out=mxGetPr(plhs[0]);
 value=mxGetPr(plhs[1]);
 dijkstra(g,u1,u2,out,value,mrows,ncols);
}
  
       


