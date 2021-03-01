#include <iostream>
#include "mex.h"
#include "matrix.h"

using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    mxArray *a_in, *b_out;
    const mwSize *dims;
    double *a, *p, *alpha_vec, *v, *b; 
    int N, n;
    double alpha;
    
    a_in = mxDuplicateArray(prhs[0]);
    dims = mxGetDimensions(prhs[0]);
    a = mxGetPr(a_in);
    N = (int) dims[0];
    
    p = mxGetPr(prhs[1]);
    
    alpha_vec = mxGetPr(prhs[2]);
    alpha = alpha_vec[0];

    v = mxGetPr(prhs[3]);
    
    b_out = plhs[0] = mxCreateDoubleMatrix(N, 1, mxREAL);
    
    b = mxGetPr(b_out);
    
   
    for (int i = 0; i < N; i++) { 
        
        b[i] = a[i]*(1 + alpha*(p[2*i]*v[0] + p[2*i + 1]*v[1]));
        
    }
}