cmake_minimum_required(VERSION 3.20)

project(meme)
set(CMAKE_VERBOSE_MAKEFILE ON)
enable_language(Fortran)
find_package(MPI REQUIRED)
add_subdirectory(src)
