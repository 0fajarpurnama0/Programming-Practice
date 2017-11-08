//%cflags=-fopenacc -O3

#include <iostream>
#include <math.h>
#include <ctime>

int main(void)
{
  int N = 50000; // 50000 elements

  float *x = new float[N];
  float *y = new float[N];

#pragma acc data copy(x, y)
  // initialize x and y arrays on the host
#pragma acc parallel loop
  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  // Timer Start
  std::clock_t start;
  double duration;
  start = std::clock();
  
  // Run kernel on 1M elements on the CPU
#pragma acc kernels
  for (int i = 0; i < N; i++)
    y[i] = x[i] + y[i];;

  duration = ( std::clock() - start ) / (double) CLOCKS_PER_SEC;
  // Timer Stop
   
  // Check for errors (all values should be 3.0f)
  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
  {
    maxError = fmax(maxError, fabs(y[i] - 3.0f));
    std::cout << "y[" << i << "] = " << y[i] << std::endl;
  }
  std::cout << "Max error: " << maxError << std::endl;
  std::cout<<"Duration for matrix addition: "<< duration <<'\n';

  // Free memory
  delete [] x;
  delete [] y;

  return 0;
}
