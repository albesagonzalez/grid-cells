#include <iostream>
#include "mex.h"
#include "matrix.h"

using namespace std;



void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    mxArray *v_out;
    const mwSize *dims;
    double *times, *pos_x, *pos_y, *v;
    double l;
    int N;
    
    dims = mxGetDimensions(prhs[0]);
    N = (int) dims[0];
    
    times = mxGetPr(prhs[0]);
    pos_x = mxGetPr(prhs[1]);
    pos_y = mxGetPr(prhs[2]);

    
    v_out = plhs[0] = mxCreateDoubleMatrix(N, 2, mxREAL);
    
    v = mxGetPr(v_out);

    double delta_t, v_x, v_y;
   
    
    for (int i = 0; i < N - 1; i++) {
        
        delta_t = times[i + 1] - times[i]; 
        v_x = (pos_x[i + 1] - pos_x[i])/(100*delta_t);
        v_y = (pos_y[i + 1] - pos_y[i])/(100*delta_t);
 
        v[i] = v_x;
        v[N + i] = v_y;
        
    }
}