program init
    implicit none
    character*500:: infile
    integer*4 :: inn, inc, jnn, jnc, nSites, nStates
    real:: p

    ! read nStates and nSites from input file
    infile = 'input.txt'
    open(unit=10, file=trim(infile), action="read")
    read(10, *) nStates
    read(10, *) nSites
    close(10)

    print *, "Please verify if the data below match your dataset"
    print *, "nStates = ", nStates
    print *, "nSites = ", nSites

    open(1, file='experimental_constraints.txt', action="read")

    open(10, file='./params/IsingHamiltonian_field.txt', action="write")
    do inn = 1, nSites
        do inc = 1, nStates
            read(1, *) p
            write(10, '(f8.5)') -log(p+0.0001)
        enddo
    enddo
    close(10)

    ! closing experimental constraints file
    close(1)

    open(10, file='./params/IsingHamiltonian_coupling.txt', action="write")
    do inn = 1, nSites
        do jnn = inn+1, nSites
            do inc = 1, nStates
                do jnc = 1, nStates
                    write(10, '(f8.6)') 0.0
                enddo
            enddo
        enddo
    enddo
    close(10)

end
