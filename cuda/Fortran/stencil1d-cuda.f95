module stencil
  integer, parameter:: radius = 3
  contains

  attributes(global) subroutine applyStencil1D(N, in, out)
    integer:: i,j
    integer, value:: N
    real:: in(N), out(N)

    !compute element index
    i = threadIdx%x + (blockIdx%x-1) * blockDim%x
    if(i .gt. radius .and. i .le. N-radius) then
      out(i) = 0
      do j = -radius, radius
	out(i) = out(i) + in(i+j)
      end do
    end if
  end subroutine
end module

program stencil1d
  use cudafor
  use stencil
  real, allocatable:: in(:), out(:)
  real, allocatable, device:: d_in(:), d_out(:)
  integer:: N
  N = 5000000

  allocate( in(N), out(N))

  call initializeArray(in, N)

  d_in = in
  call applyStencil1D<<<N/256, 256>>>(N, d_in, d_out)
  out = d_out

  dealocate(in, out)
end program
