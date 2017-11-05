import numpy as np
from timeit import default_timer as timer

def VectorAdd(a, b, c):
  for i in xrange(a.size):
    c[i] = a[i] + b[i]

def main():
  N = 32000000 # Number of elements per Array

  A = np.ones(N, dtype=np.float32)
  B = np.ones(N, dtype=np.float32)
  C = np.zeros(N, dtype=np.float32)

  start = timer()
  VectorAdd(A, B, C)
  vectoradd_time = timer() - start
  
  print("C[:5] = " + str(C[:5]))
  print("C[-5:] = " + str(C[-5:]))

  print("Vector Add took %f seconds" % vectoradd_time)

if __name__ == '__main__':
  main()
