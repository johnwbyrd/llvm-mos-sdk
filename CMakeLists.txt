cmake_minimum_required(VERSION 3.17)
project(llvm-mos-sdk 
  DESCRIPTION "LLVM-based SDK for the MOS 65xx series of processors"
  HOMEPAGE_URL "https://github.com/llvm-mos/llvm-mos-sdk"
  LANGUAGES ASM C
)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
include(llvm-mos/Toolchain)

if(LLVM_MOS_BOOTSTRAP_COMPILER)
else()
add_subdirectory(src)
endif()
