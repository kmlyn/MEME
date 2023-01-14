set(SHARED_SRC global.f90 hamiltonian.f90 mc_sampling.f90 ensemble_average.f90)
set(INIT_SRC init.f90)
set(MAIN_SRC main.f90 ${SHARED_SRC})
set(ENERGY_SRC energy.f90 ${SHARED_SRC})

add_executable(meme_init ${INIT_SRC})

add_executable(meme_main ${MAIN_SRC})
add_definitions(${MPI_Fortran_COMPILE_FLAGS})
include_directories(${MPI_Fortran_INCLUDE_PATH})
link_directories(${MPI_Fortran_LIBRARIES})
target_link_libraries(meme_main ${MPI_Fortran_LIBRARIES})

add_executable(meme_energy ${ENERGY_SRC})

install(TARGETS meme_init meme_main meme_energy DESTINATION bin)