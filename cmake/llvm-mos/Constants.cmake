# Constants.cmake
# Constants for the llvm-mos build
include_guard(GLOBAL)

set(LLVM_MOS_GENERATE_LINK_REPORTS "ON"
  CACHE STRING "Generate detailed objdump and dwarfdump files when linking")
set(CMAKE_SYSTEM_NAME "llvm-mos")
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake
  CACHE PATH "Path to CMake modules required to build ${PROJECT_NAME}")
set(LLVM_MOS_ASSEMBLER_NAME "llvm-mc"
  CACHE STRING "Name of assembler program")
set(LLVM_MOS_ASSEMBLER_PATH "LLVM_MOS_ASSEMBLER_PATH-NOTFOUND"
  CACHE PATH "Location of the llvm-mos llvm-mc executable on your system")
set(LLVM_MOS_ASSEMBLER_DETECTION_STRING "mos"
  CACHE STRING "Word to detect in assembler --version command to prove support \
  for llvm-mos")
set(LLVM_MOS_TRIPLE "mos"
  CACHE STRING "LLVM triple to use to target MOS processors")
set(CMAKE_C_COMPILER_INIT "clang"
  CACHE STRING "Only accept the clang compiler when searching for a C compiler")
set(CMAKE_CXX_COMPILER_INIT "clang++"
  CACHE STRING "Only accept the clang++ compiler when searching for a C++ \
  compiler")
set(CMAKE_EXECUTABLE_SUFFIX ".elf"
  CACHE STRING "The default executable suffix for ELF executables produced by \
  llvm-mos")
set(LLVM_MOS_STRIPPED_EXECUTABLE_SUFFIX ".bin"
  CACHE STRING "The default suffix for stripped executables produced by \
  llvm-mos")


