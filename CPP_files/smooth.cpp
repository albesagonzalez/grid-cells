#include <iostream>
#include "mex.h"
#include "matrix.h"

using namespace std;

bool close (float x_0, float y_0, float x_1, float y_1, float r)
{
    float dx = abs(x_1 - x_0);
    float dy = abs(y_1 - y_0);
    float d = sqrt(dx*dx + dy*dy);
    
    if (d < r && d != 0)
        return true;
    else 
        return false;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    mxArray *x, *y, *x_matlab, *y_matlab;
    const mwSize *dims;
    double *x_out, *y_out, *x_in, *y_in;
    int N;
    
    x_matlab = mxDuplicateArray(prhs[0]);
    y_matlab = mxDuplicateArray(prhs[1]);
    dims = mxGetDimensions(prhs[0]);
    x_in = mxGetPr(x_matlab);
    y_in = mxGetPr(y_matlab);
    N = (int) dims[1];
    
    x = plhs[0] = mxCreateDoubleMatrix(N, 1, mxREAL);
    y = plhs[1] = mxCreateDoubleMatrix(N, 1, mxREAL);
    
    x_out = mxGetPr(x);
    y_out = mxGetPr(y);
    
    
    double av_x, av_y, x_start, y_start, x_end, y_end;
    
    int count;
   
    for (int i = 0; i < N; i++) {
        av_x = x_in[i];
        av_y = y_in[i];
        x_start = x_in[i];
        y_start = y_in[i];
        count = 1;
        for (int j = 0; j < N; j++){
            x_end = x_in[j];
            y_end = y_in[j];
            if (close(x_start, y_start, x_end, y_end, 6)){
                count ++;
                av_x = av_x + x_end;
                av_y = av_y + y_end;
             }      
        }
        x_out[i] = av_x/count;
        y_out[i] = av_y/count;
    }
}