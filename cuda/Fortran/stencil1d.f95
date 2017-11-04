module stencil
  integer, parameter:: radius = 3
  contains

  subroutine applyStencil1D(N, in, out)
    integer:: i,j,N
    real:: in(N), out(N)

    !loop over interior elements
    do i = radius+1, N-radius
      !loop over stencil
      out(i) = 0
      do j = -radius, radius
	out(i) = out(i) + in(i+j)
      end do
    end do
  end subroutine
end module

program stencil1d
  use stencil
  real, allocatable:: in(:), out(:)
  integer:: N
  N = 5000000

  allocate( in(N), out(N))

  call initializeArray(in, N)

  call applyStencil1D(N, in, out)

  dealocate(in, out)
end program
