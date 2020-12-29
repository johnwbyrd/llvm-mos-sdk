cmake_minimum_required(VERSION 3.17)
project(llvm-mos-sdk 
  DESCRIPTION "LLVM-based SDK for the MOS 65xx series of processors"
  HOMEPAGE_URL "https://github.com/johnwbyrd/llvm-mos-sdk"
  LANGUAGES C CXX ASM
)

set(LLVM_MOS_CMAKE_MODULES_DIR ${CMAKE_SOURCE_DIR}/cmake
	CACHE PATH "Path to required CMake modules")
set(CMAKE_MODULE_PATH ${LLVM_MOS_CMAKE_MODULES_DIR}
  CACHE PATH "Path to required CMake modules")
set(LLVM_MOS_GIT_REPOSITORY https://github.com/johnwbyrd/llvm-mos.git 
  CACHE STRING "The git repository to download llvm-mos from")

include(ExternalProject)

ExternalProject_Add( llvm-mos
  GIT_REPOSITORY ${LLVM_MOS_GIT_REPOSITORY}
  GIT_PROGRESS 1
  CMAKE_ARGS
    -C ${LLVM_MOS_CMAKE_MODULES_DIR}/llvm-mos.cmake
     <SOURCE_DIR>/llvm
  CMAKE_CACHE_ARGS 
    -DCMAKE_INSTALL_PREFIX:STRING=<INSTALL_DIR>/llvm-mos
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
  TEST_COMMAND cmake --build . --target distribution
  TEST_BEFORE_INSTALL 1
  USES_TERMINAL_DOWNLOAD 1
  USES_TERMINAL_UPDATE 1
  USES_TERMINAL_CONFIGURE 1
  USES_TERMINAL_BUILD 1
  USES_TERMINAL_INSTALL 1
  USES_TERMINAL_TEST 1
)

if (NOT DEFINED LLVM_MOS_INSTALL_DIR)
  ExternalProject_Get_Property( llvm-mos INSTALL_DIR)
  set( LLVM_MOS_INSTALL_DIR ${INSTALL_DIR}/llvm-mos
    CACHE PATH "Root of llvm-mos build products directory")
endif(NOT DEFINED LLVM_MOS_INSTALL_DIR)

if (NOT DEFINED LLVM_MOS_BINARY_DIR)
  ExternalProject_Get_Property( llvm-mos INSTALL_DIR)
  set( LLVM_MOS_BINARY_DIR ${LLVM_MOS_INSTALL_DIR}/bin
    CACHE PATH "Binary path to llvm and clang executables to be used to build samples and libraries")
endif(NOT DEFINED LLVM_MOS_BINARY_DIR)

add_subdirectory(src)
