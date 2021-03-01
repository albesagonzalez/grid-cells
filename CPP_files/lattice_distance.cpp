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

double distance (float x_0, float y_0, float x_1, float y_1)
{
    float dx = abs(x_1 - x_0);
    float dy = abs(y_1 - y_0);
    float d = sqrt(dx*dx + dy*dy);
    
    return d;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    mxArray *distance_mx, *x_matlab, *y_matlab, *radius_matlab;
    const mwSize *dims;
    double *x_out, *y_out, *x_in, *y_in, *radius_vec, *distance_out;
    double radius;
    int N;
    
    x_matlab = mxDuplicateArray(prhs[0]);
    y_matlab = mxDuplicateArray(prhs[1]);
    radius_matlab = mxDuplicateArray(prhs[2]);
    dims = mxGetDimensions(prhs[0]);
    x_in = mxGetPr(x_matlab);
    y_in = mxGetPr(y_matlab);
    radius_vec = mxGetPr(radius_matlab);
    radius = radius_vec[0];
    N = (int) dims[0];
    
    distance_mx = plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    
    distance_out = mxGetPr(distance_mx);

    
    
    double x_start, y_start, x_end, y_end;
    
    int count;
    
    distance_out[0] = 0;
    count = 0;
    for (int i = 0; i < N; i++) {
        x_start = x_in[i];
        y_start = y_in[i];
        for (int j = 0; j < N; j++){
            x_end = x_in[j];
            y_end = y_in[j];
            if (close(x_start, y_start, x_end, y_end, radius)){
                count ++;
                distance_out[0] = distance_out[0] + distance(x_start, y_start, x_end, y_end);
             }      
        }
        
    }
    
    distance_out[0] = distance_out[0] / count;
}