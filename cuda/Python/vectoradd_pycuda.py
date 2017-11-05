import numpy as np
from timeit import default_timer as timer
import pycuda.autoinit
import pycuda.gpuarray as gpuarray

def main():
  N = 32000000 # Number of elements per Array

  A = gpuarray.to_gpu(np.ones(N, dtype=np.float32))
  B = gpuarray.to_gpu(np.ones(N, dtype=np.float32))

  start = timer()
  C = (A + B).get()
  vectoradd_time = timer() - start
    
  print("C[:5] = " + str(C[:5]))
  print("C[-5:] = " + str(C[-5:]))

  print("Vector Add took %f seconds" % vectoradd_time)
    
if __name__ == '__main__':
  main()
