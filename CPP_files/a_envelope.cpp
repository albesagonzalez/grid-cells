#include <iostream>
#include "mex.h"
#include "matrix.h"

using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mxArray *b_out;
    double *arguments, *b;
    int N, n;
    double a_0, R, r;
    
    arguments = mxGetPr(prhs[0]);
    
    N = arguments[0];
    n = sqrt(N);
    a_0 = arguments[1];
    R = arguments[2];
    r = arguments[3];
    
    b_out = plhs[0] = mxCreateDoubleMatrix(N, 1, mxREAL);
    b = mxGetPr(b_out);
    
    int neurons_x [N];
    int neurons_y [N];
    
    double reference, delta_x, delta_y;
    
    reference = -double(n)/2;
    
    for (int i = 0; i < N; i++){
        delta_x = double(i/n);
        delta_y = double(i%n);
        neurons_x[i] = reference + delta_x;
        neurons_y[i] = reference + delta_y;
        }
    
    double abs_x, in, frac;
   
    for (int i = 0; i < N; i++) {
        abs_x = sqrt(neurons_x[i]*neurons_x[i] + neurons_y[i]*neurons_y[i]);
        
        frac = (abs_x - R + r)/r;
        
        if (frac < 0)
            b[i] = 1;
        else
            b[i] = exp(-a_0*frac*frac);
    }
}