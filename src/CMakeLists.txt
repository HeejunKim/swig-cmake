cmake_minimum_required(VERSION 3.1)

project(CMAKE_SWIG_TEST)

include_directories(
    ${CMAKE_SWIG_SRC_SOURCE_DIR}
)

add_library(cmake_swig_test SHARED
    cmake_swig_test.c
)

install(TARGETS cmake_swig_test
    DESTINATION lib
)
