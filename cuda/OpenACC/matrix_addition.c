//%cflags: -fopenacc -O3

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <time.h>
#define SIZE 102400

int main( int argc, char* argv[] )
{
  
  int *a, *b, *c;

  a = (int *)malloc(SIZE * sizeof(int));
  b = (int *)malloc(SIZE * sizeof(int));
  c = (int *)malloc(SIZE * sizeof(int));

#pragma acc data copy(a, b, c) 
#pragma acc parallel loop
  for (int i = 0; i < SIZE; ++i)
  {
    a[i] = i;
    b[i] = i;
    c[i] = 0;
  }

  struct timespec start, end;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  
#pragma acc kernels //automatically let openacc determine
  for (int i = 0; i < SIZE; ++i)
  {
    c[i] = a[i] + b[i];
  }

  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  uint64_t delta_us = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000;

  for (int i = 0; i < SIZE; ++i)
    printf("c[%d] = %d\n", i, c[i]);

  free(a);
  free(b);
  free(c);
  

  
  printf("Vector addition executed in ""%"PRId64" milliseconds.\n", delta_us);
  
  return 0;
}
