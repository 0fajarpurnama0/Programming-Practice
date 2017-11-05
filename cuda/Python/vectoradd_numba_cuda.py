import numpy as np
from timeit import default_timer as timer
from numba import vectorize

import os

@vectorize(["float32(float32, float32)"], target='cuda')
def VectorAdd(a, b):
  return a + b

def main():
  
  os.environ['NUMBAPRO_NVVM']="/usr/lib/x86_64-linux-gnu/libnvvm.so"
  os.environ['NUMBAPRO_LIBDEVICE']="/usr/lib/nvidia-cuda-toolkit/libdevice"
    
  N = 32000000 # Number of elements per Array

  A = np.ones(N, dtype=np.float32)
  B = np.ones(N, dtype=np.float32)
  C = np.zeros(N, dtype=np.float32)

  start = timer()
  C = VectorAdd(A, B)
  vectoradd_time = timer() - start
  
  print("C[:5] = " + str(C[:5]))
  print("C[-5:] = " + str(C[-5:]))

  print("Vector Add took %f seconds" % vectoradd_time)

if __name__ == '__main__':
  main()
