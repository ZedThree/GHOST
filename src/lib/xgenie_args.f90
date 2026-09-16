! Command-line access for xgenieIF.c through Fortran 2003 intrinsics, so that
! the C code no longer has to guess the Fortran runtime's IARGC/GETARG symbols
! (which differ between gfortran, ifort/ifx and others).

function ghost_arg_count() bind(C, name='ghost_arg_count') result(n)
  use iso_c_binding, only: c_int
  implicit none
  integer(c_int) :: n
  n = command_argument_count()
end function ghost_arg_count

! Fill buf(1:buflen) with argument i, blank padded (GETARG semantics)
subroutine ghost_get_arg(i, buf, buflen) bind(C, name='ghost_get_arg')
  use iso_c_binding, only: c_int, c_char
  implicit none
  integer(c_int), value :: i, buflen
  character(kind=c_char) :: buf(*)
  character(len=buflen) :: arg
  integer :: k
  call get_command_argument(i, arg)
  do k = 1, buflen
    buf(k) = arg(k:k)
  end do
end subroutine ghost_get_arg
