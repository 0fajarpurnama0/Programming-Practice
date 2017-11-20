library(rbenchmark)

host_a <- runif(1000000,1,1)

benchmark(sum(host_a))

sum(host_a)