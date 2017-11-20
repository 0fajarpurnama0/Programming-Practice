library(gmatrix)
library(rbenchmark)

host_a <- runif(10000000,1,1)

#Creating GPU objects
gpu_a = g(host_a)

#Perform some simple calculations
benchmark(sum(gpu_a))

#Move data back to the host
host_ans = h(gpu_ans)
host_ans