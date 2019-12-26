subroutine print_hello() bind(C)
    implicit none
    write(*,*) "Hello from Fortran."
end subroutine print_hello
