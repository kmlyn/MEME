Program energy

    Use global
    Use mc_sampling
    Use hamiltonian

    implicit none

    character*500:: infile
    integer*4 :: inn, inc

    integer*4, allocatable :: IsingVar(:)

    double precision :: totE

    integer :: i, ioerr, lineno

    ! read input file
    infile = 'input.txt'
    open(unit=10, file=trim(infile), action="read")
    read(10, *) nStates
    read(10, *) nSites
    close(10)

    print *, "Please verify if the data below match your dataset"
    print *, "nStates = ", nStates
    print *, "nSites = ", nSites

    ! allocate variables
    allocate(IsingVar(nSites))
    allocate(field(nSites, nStates))
    allocate(coupling(nSites, nSites, nStates, nStates))

    call init_ham()

    open(unit=1, file='msa_mut_non_gap.txt', action="read")
    open(unit=11, file='msa_mut_MaxEnt_energy.txt', status='replace')

    ioerr = 0
    lineno = 0
    ! processes as many sequences as there is in the file and not hardcoded mut_num
    do
        do inn=1,nSites
            if(inn==nSites)then
                read(1,'(i2)', iostat=ioerr) IsingVar (inn)
            else
                read(1,'(i3)', advance='no', iostat=ioerr) IsingVar (inn)
            endif
        end do

        lineno = lineno + 1
        if (ioerr /= 0) then
            lineno = lineno - 1
            print *, "Finished reading input, read ", lineno, " lines with exit code ", ioerr
            print *, "Please verify if you had indeed ", lineno, " records to process."
            print *, "Exiting..."
            exit
        end if

        call eval_tot_energy(IsingVar, totE)
        write(11,*) totE

    enddo

    ! close msa_mut_MaxEnt_energy.txt
    close(11)
    ! close msa_mut_non_gap.txt
    close(1)

    call free_ham()

    print *, "Run finished."

end program

