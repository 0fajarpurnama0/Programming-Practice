#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <inttypes.h>
#include <time.h>
#define SIZE 102400

__global__ void VectorAdd(int *a, int *b, int *c, int n)
{
  // Get our global thread ID
  int i = blockIdx.x*blockDim.x+threadIdx.x;

  //for (i = 0; i < n; ++i) // replaced

  // Make sure we do not go out of bounds
  if (i < n)
    c[i] = a[i] + b[i];
}

int main( int argc, char* argv[] )
{
  int *cpu_a, *cpu_b, *cpu_c;
  int *gpu_a, *gpu_b, *gpu_c;
  int blockSize, gridSize;
  

  size_t bytes = SIZE * sizeof(int);

  // Allocate memory for each vector on CPU
  cpu_a = (int *)malloc(bytes);
  cpu_b = (int *)malloc(bytes);
  cpu_c = (int *)malloc(bytes);
  
  // Allocate memory for each vector on GPU
  cudaMalloc(&gpu_a, bytes);
  cudaMalloc(&gpu_b, bytes);
  cudaMalloc(&gpu_c, bytes);

  for (int i = 0; i < SIZE; ++i)
  {
    cpu_a[i] = i;
    cpu_b[i] = i;
    cpu_c[i] = 0;
  }
  
  // Copy host vectors to device
  cudaMemcpy( gpu_a, cpu_a, bytes, cudaMemcpyHostToDevice);
  cudaMemcpy( gpu_b, cpu_b, bytes, cudaMemcpyHostToDevice);
  
  // Number of threads in each thread block
  blockSize = 1024;
 
  // Number of thread blocks in grid
  gridSize = (int)ceil((float)SIZE/blockSize);

  struct timespec start, end;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);  

  VectorAdd <<<gridSize, blockSize>>> (gpu_a, gpu_b, gpu_c, SIZE);

  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  uint64_t delta_us = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000;
  
  cudaMemcpy(cpu_c, gpu_c, bytes, cudaMemcpyDeviceToHost);

  for (int i = 0; i < SIZE; ++i)
    printf("c[%d] = %d\n", i, cpu_c[i]);

  cudaFree(gpu_a);
  cudaFree(gpu_b);
  cudaFree(gpu_c);

  free(cpu_a);
  free(cpu_b);
  free(cpu_c);

  

  
  printf("Vector addition executed in ""%"PRId64" milliseconds.\n", delta_us);
  
  return 0;
}
