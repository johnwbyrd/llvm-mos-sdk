cmake_minimum_required(VERSION 3.17)
project(llvm-mos-sdk 
  DESCRIPTION "LLVM-based SDK for the MOS 65xx series of processors"
  HOMEPAGE_URL "https://github.com/johnwbyrd/llvm-mos-sdk"
  LANGUAGES C CXX
)

include(ExternalProject)
include(CMakePrintHelpers)

ExternalProject_Add( llvm-mos
  GIT_REPOSITORY https://github.com/johnwbyrd/llvm-mos.git
  GIT_PROGRESS 1
  CMAKE_CACHE_ARGS -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD:STRING=MOS -DLLVM_ENABLE_PROJECTS:STRING=clang\;lld -DLLVM_LIT_TOOLS_DIR:STRING=C:/Program\ Files/git/usr/bin
  CMAKE_ARGS ${CMAKE_ARGS} -G Ninja -DLLVM_OPTIMIZED_TABLEGEN=1 -DLIBXML2_LIBRARIES=IGNORE -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_TARGETS_TO_BUILD=all ../llvm-mos/llvm
  TEST_COMMAND cmake --target check-all
  INSTALL_COMMAND cmake --target install
  USES_TERMINAL_DOWNLOAD 1
  USES_TERMINAL_UPDATE 1
  USES_TERMINAL_CONFIGURE 1
  USES_TERMINAL_BUILD 1
  USES_TERMINAL_INSTALL 1
  USES_TERMINAL_TEST 1
)

# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#     message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()