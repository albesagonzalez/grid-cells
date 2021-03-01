#include <iostream>
#include "mex.h"
#include "matrix.h"

using namespace std;


float ToroidalDistance (int n, float x1, float y1, float x2, float y2)
{
    float dx = abs(x2 - x1);
    float dy = abs(y2 - y1);
 
    if (dx > 0.5*n)
        dx = n - dx;
 
    if (dy > 0.5*n)
        dy = n - dy;
 
    return dx*dx + dy*dy;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    mxArray *b_out;
    const mwSize *dims;
    double *l_vec, *p, *b; 
    double l;
    int N, n;
    
    dims = mxGetDimensions(prhs[0]);
    N = (int) dims[0];
    n = sqrt(N);
    
    l_vec = mxGetPr(prhs[1]);
    l = l_vec[0];
    p = mxGetPr(prhs[2]);

    
    b_out = plhs[0] = mxCreateDoubleMatrix(N, N, mxREAL);
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
    
    int i, j;
    
    double e_1, e_2, x_i1, x_i2, x_j1, x_j2, abs_x, x_1, x_2;
   
    for (int k = 0; k < N*N; k++) {
        i = k%N;
        j = k/N;
        
        e_1 = l*p[2*j];
        e_2 = l*p[2*j + 1];
        
        x_i1 = neurons_x[i];
        x_i2 = neurons_y[i];
                
        x_j1 = neurons_x[j] + e_1;
        x_j2 = neurons_y[j] + e_2;     
        
        b[k] = ToroidalDistance(n, x_i1, x_i2, x_j1, x_j2);
        
        
        //x_2 = x_i2 - x_j2;
        
        //x_1 = x_i1 - x_j1;
        
        //b[k] = x_1*x_1 + x_2*x_2;
        

        
    }
}