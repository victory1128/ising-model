//
//
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
    if(a >= 0)
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
    // H,sigma,J,h,beta,itermax,S
    double H,J,h,beta,deltaH,deltaS;
    double* pdSigma;
    int itermax,N,nS;
    int nrow,ncol;
    double* gamma;
    double A,r;
    int i,j,k;
    double* pdS;
    
    
    H = *(mxGetPr(prhs[0]));
    pdSigma = mxGetPr(prhs[1]);
    N = mxGetM(prhs[1]);
    J = *(mxGetPr(prhs[2]));
    h = *(mxGetPr(prhs[3]));
    beta = *(mxGetPr(prhs[4]));
    itermax = (int)*(mxGetPr(prhs[5]));
    pdS = mxGetPr(prhs[6]);

    nS = N/2;
    plhs[0] = mxCreateDoubleMatrix(nS,1,mxREAL);
    gamma = mxGetPr(plhs[0]);
    for(j = 0; j < nS; j++){
        gamma[j] = pdS[j];
    }
    
    srand((unsigned int)time(NULL));
    for(i = 0; i < itermax; i++ ){
    
        nrow = rand()%N;
        ncol = rand()%N;
        deltaH = 2*J*pdSigma[nrow*N+ncol] * ( pdSigma[rem(nrow-1,N)*N+ncol] + pdSigma[rem(nrow+1,N)*N+ncol] +
                                             pdSigma[nrow*N+rem(ncol-1,N)] + pdSigma[nrow*N+rem(ncol+1,N)] ) + 2*h*pdSigma[nrow*N+ncol];
        A = min(1,exp(-beta*deltaH));
        r = ((double)rand())/RAND_MAX;
        if(r < A){
            pdSigma[nrow*N+ncol] = -pdSigma[nrow*N+ncol];
            for(j = 1; j < nS ; j++){
                pdS[j] = pdS[j] + 2*pdSigma[nrow*N+ncol] * ( pdSigma[rem(nrow-j,N)*N+ncol] + pdSigma[rem(nrow+j,N)*N+ncol] + pdSigma[nrow*N+rem(ncol-j,N)] + pdSigma[nrow*N+rem(ncol+j,N)] )/(N*N*4);
            }
        }
        for(j = 0; j < nS; j++){
                gamma[j] += pdS[j];
        }
    }
    
    for(j = 0; j < nS; j++){
        gamma[j] = gamma[j] / itermax;
    }
}







