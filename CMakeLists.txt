cmake_minimum_required(VERSION 3.10)
project(llvm-mos-sdk 
  DESCRIPTION "LLVM-based SDK for the MOS 65xx series of processors"
  HOMEPAGE_URL "https://github.com/llvm-mos/llvm-mos-sdk"
  LANGUAGES ASM C
)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
include(llvm-mos/Toolchain)

add_subdirectory(src)
