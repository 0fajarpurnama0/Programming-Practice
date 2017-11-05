#include <iostream>
#include <math.h>
#include <ctime>

// CUDA Kernel function to add the elements of two arrays on the GPU

__global__ void add(int n, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n)
      y[i] = x[i] + y[i];
}

int main(void)
{
  int N = 50000; // 50k elements

  float *cpu_x, *cpu_y, *gpu_x, *gpu_y;

  size_t bytes = N * sizeof(float);
  
  cpu_x = (float *)malloc(bytes);
  cpu_y = (float *)malloc(bytes);

  cudaMalloc(&gpu_x, bytes);
  cudaMalloc(&gpu_y, bytes);
  
  // initialize x and y arrays on the host
  for (int i = 0; i < N; i++) {
    cpu_x[i] = 1.0f;
    cpu_y[i] = 2.0f;
  }
  
  cudaMemcpy( gpu_x, cpu_x, bytes, cudaMemcpyHostToDevice);
  cudaMemcpy( gpu_y, cpu_y, bytes, cudaMemcpyHostToDevice);
  
  int blockSize = 1024;
  int numBlocks = (N + blockSize -1) / blockSize;
  
  // Timer Start
  std::clock_t start;
  double duration;
  start = std::clock();
  
  // Run kernel on 1M elements on the GPU
  add<<<numBlocks, blockSize>>>(N, gpu_x, gpu_y);

  duration = ( std::clock() - start ) / (double) CLOCKS_PER_SEC;
  // Timer Stop
   
  cudaMemcpy(cpu_y, gpu_y, bytes, cudaMemcpyDeviceToHost);

  // Check for errors (all values should be 3.0f)
  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
  {
    maxError = fmax(maxError, fabs(cpu_y[i] - 3.0f));
    std::cout << "y[" << i << "] = " << cpu_y[i] << std::endl;
  }
  std::cout << "Max error: " << maxError << std::endl;
  std::cout<<"Duration for matrix addition: "<< duration <<'\n';

  // Free memory

  cudaFree(gpu_x);
  cudaFree(gpu_y);

  delete [] cpu_x;
  delete [] cpu_y;

  return 0;
}
