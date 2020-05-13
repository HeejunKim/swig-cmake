cmake_minimum_required(VERSION 3.1)

# SWIG: use standard target name.
if(POLICY CMP0078) 
    cmake_policy(SET CMP0078 NEW)
endif()

# SWIG: use SWIG_MODULE_NAME property.
if(POLICY CMP0086) 
    cmake_policy(SET CMP0086 NEW)
endif()

project(CMAKE_SWIG_WRAPPER)

find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})

include_directories(
    ${CMAKE_SWIG_TEST_SOURCE_DIR}
)

link_directories(
    ${CMAKE_SWIG_TEST_SOURCE_DIR}
)

### Swig Module
set(CMAKE_SWIG_FLAGS)
set(SWIG_MODULE_NAME cmake_swig_wrapper)
#set(SWIG_CXX_EXTENSION cpp)
set(CMAKE_SWIG_OUTDIR "${CMAKE_CURRENT_BINARY_DIR}/swig")

set(WRAPPER_SWIG ${CMAKE_CURRENT_SOURCE_DIR}/cmake_swig_test.i)
set_property(SOURCE ${WRAPPER_SWIG} PROPERTY CPLUSPLUS ON)
set_property(SOURCE ${WRAPPER_SWIG} APPEND PROPERTY SWIG_FLAGS -namespace "test.cmake.swig")
set(SWIG_MODULE_${SWIG_MODULE_NAME}_EXTRA_DEPS ${WRAPPER_SWIG})

if(COMMAND swig_add_library)
    swig_add_library(${SWIG_MODULE_NAME} TYPE SHARED LANGUAGE csharp SOURCES ${WRAPPER_SWIG})
else()
    swig_add_module(${SWIG_MODULE_NAME} csharp ${WRAPPER_SWIG})
endif()
message(STATUS "swig target real name: '${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}'")

set_target_properties("${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}" PROPERTIES LINK_FLAGS "-flat_namespace -undefined suppress")

swig_link_libraries("${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}"
    cmake_swig_test
)

set_target_properties("${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}" PROPERTIES PREFIX "lib")

install(TARGETS "${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}"
    DESTINATION lib
)

install(
    DIRECTORY ${CMAKE_SWIG_OUTDIR}
    DESTINATION ${CMAKE_INSTALL_PREFIX}
    COMPONENT "${SWIG_MODULE_${SWIG_MODULE_NAME}_REAL_NAME}"
    FILES_MATCHING PATTERN "*.cs"
)
