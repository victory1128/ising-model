//
//  mcmc.c
//  matlab
//
//  Created by Li Yongfeng on 15/11/23.
//  Copyright © 2015 PKU. All rights reserved.
//

#include <stdio.h>
#include "mex.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>

double min(double a, double b){
    if(a < b){
        return a;
    }
    else{
        return b;
    }
}

int rem(int a,int b)
{
    int c;
    if(a>=0)
        return (a%b);
    else{
        c = a%b;
        if (c == 0) {
            return 0;
        }
        else{
            return b + a%b;
        }
    }
}


void mexFunction(int nlhs, mxArray *plhs[], /* Output variables */
                 int nrhs, const mxArray *prhs[]) /* Input variables */
{
    // H,sigma,J,h,beta,itermax,M
    double H,J,h,beta,deltaH,S,deltaS;
    double* pdSigma;
    int itermax,N;
    int nrow,ncol;
    double* M;
    double A,r;
    int i;
    double HSquMean = 0,HMean = 0;
    
    plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    M = mxGetPr(plhs[0]);
    H = *(mxGetPr(prhs[0]));
    pdSigma = mxGetPr(prhs[1]);
    N = mxGetM(prhs[1]);
    J = *(mxGetPr(prhs[2]));
    h = *(mxGetPr(prhs[3]));
    beta = *(mxGetPr(prhs[4]));
    itermax = (int)*(mxGetPr(prhs[5]));
    S = *(mxGetPr(prhs[6]));
    *M = 0;
    
    srand((unsigned int)time(NULL));
    for(i = 0; i < itermax; i++ ){
        
        nrow = rand()%N;
        ncol = rand()%N;
        deltaH = 2*J*pdSigma[nrow*N+ncol] * ( pdSigma[rem(nrow-1,N)*N+ncol] + pdSigma[rem(nrow+1,N)*N+ncol] +
                                             pdSigma[nrow*N+rem(ncol-1,N)] + pdSigma[nrow*N+rem(ncol+1,N)] ) + 2*h*pdSigma[nrow*N+ncol];
        deltaS = -2*pdSigma[nrow*N+ncol];
        A = min(1,exp(-beta*deltaH));
        r = ((double)rand())/RAND_MAX;
        if(r < A){
            pdSigma[nrow*N+ncol] = -pdSigma[nrow*N+ncol];
            H += deltaH;
            S += deltaS;
        }
        *M += S;
    }
    
    *M = *M / itermax;
}





