#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <time.h>
#define SIZE 1024

__global__ void VectorAdd(int *a, int *b, int *c, int n)
{
  int i = blockIdx.x*blockDim.x+threadIdx.x;

  //for (i = 0; i < n; ++i)
  if (i < n)
    c[i] = a[i] + b[i];
}

int main()
{
  struct timespec start, end;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  
  int *a, *b, *c;

  cudaMallocManaged(&a, SIZE * sizeof(int));
  cudaMallocManaged(&b, SIZE * sizeof(int));
  cudaMallocManaged(&c, SIZE * sizeof(int));

  for (int i = 0; i < SIZE; ++i)
  {
    a[i] = i;
    b[i] = i;
    c[i] = 0;
  }

  VectorAdd <<<1, SIZE>>> (a, b, c, SIZE);
  
  cudaDeviceSynchronize();

  for (int i = 0; i < SIZE; ++i)
    printf("c[%d] = %d\n", i, c[i]);

  cudaFree(a);
  cudaFree(b);
  cudaFree(c);
  
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  uint64_t delta_us = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000;
  
  printf("Code executed in ""%"PRId64" milliseconds.\n", delta_us);
  
  return 0;
}
