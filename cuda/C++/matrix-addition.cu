#include <stdio.h>
#include <iostream>
#include <math.h>
#include <ctime>

// CUDA Kernel function to add the elements of two arrays on the GPU
__global__ void add(int n, float *x, float *y)
{

  int index = threadIdx.x;
  int stride = blockDim.x;
  for (int i = index; i < n; i+= stride)
      y[i] = x[i] + y[i];
}

int main(void)
{
  int N = 1<<20; // 1M elements

  float *x, *y;
  
  cudaMallocManaged(&x, N*sizeof(float));
  cudaMallocManaged(&y, N*sizeof(float));

  // initialize x and y arrays on the host
  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  // Timer Start
  std::clock_t start;
  double duration;
  start = std::clock();
  
  int blockSize = 1024;
  int numBlocks = (N + blockSize -1) / blockSize;
  // Run kernel on 1M elements on the CPU
  add<<<numBlocks, blockSize>>>(N, x, y);

  duration = ( std::clock() - start ) / (double) CLOCKS_PER_SEC;
  // Timer Stop
   
  cudaDeviceSynchronize();

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

  cudaFree(x);
  cudaFree(y);

  //delete [] x;
  //delete [] y;

  return 0;
}
