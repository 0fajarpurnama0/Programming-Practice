program variables

! This simple program does operators
 implicit none

! Type declarations
 real :: a, b, c, d, e, f
 character(len=20) :: firstname, lastname, text

! Executable statements
 write (*,'(A)',advance='no') 'enter your firstname: '
 read (*,*) firstname
 write (*,'(A)',advance='no') 'enter your lastname: '
 read (*,*) lastname
 write (*,*) 'Hello ', firstname, lastname 
 text = 'We will do calculations.'
 write (*,*) text
 write (*,'(A)',advance='no') 'Enter first digit: '
 read (*,*) a
 write (*,'(A)',advance='no') 'Enter last digit: '
 read (*,*) b
 c = a + b
 d = a - b
 e = a * b
 f = a / b
 print *, 'a + b = ', c
 print *, 'a - b = ', d
 print *, 'a * b = ', e
 print *, 'a / b = ', f

end program variables
