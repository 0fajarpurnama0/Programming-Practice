#Put here the CPU BLAS fallback Library of your choice
NVBLAS_CPU_BLAS_LIB libopenblas.so

# Specify which output log file (default is stderr)
NVBLAS_LOGFILE nvblas.log

# List of GPU devices Id to participate to the computation 
# By default if no GPU are listed, only device 0 will be used
NVBLAS_GPU_LIST 0 1
NVBLAS_AUTOPIN_MEM_ENABLED

M = 512*512; N = 2048; K = 2048;
A = rand(K,M,"single"); B = rand(K,N,"single");

# Count total elapsed time
tic

#Assume matrices are stored columnwise
A = A / diag(norm(A,"columns")); B = B / diag(norm(B,"columns"));

# Time sgemm only
start = clock();
C = transpose(B)*A;
elapsedTime = etime(clock(), start);

# Find maximum value in each column and store in a vector
SAM=max(C);
toc
disp(elapsedTime);
gFlops = 2*M*N*K/(elapsedTime * 1e+9);
disp(gFlops);
