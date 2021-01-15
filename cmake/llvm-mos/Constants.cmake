# Constants.cmake
# Constants for the llvm-mos build
include_guard(GLOBAL)

set(CMAKE_C_COMPILER_INIT "clang"
  CACHE STRING "Only accept the clang compiler when searching for a C compiler")
set(CMAKE_CXX_COMPILER_INIT "clang++"
  CACHE STRING "Only accept the clang++ compiler when searching for a C++ \
  compiler")
set(CMAKE_EXECUTABLE_SUFFIX ".elf"
  CACHE STRING "The default executable suffix for ELF executables produced by \
  llvm-mos")
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake
    CACHE PATH "Path to CMake modules required to build ${PROJECT_NAME}")
set(CMAKE_SYSTEM_NAME "llvm-mos")  
set(LLVM_MOS_ASSEMBLER_DETECTION_STRING "mos"
  CACHE STRING "Word to detect in assembler --version command to prove support \
  for llvm-mos")
set(LLVM_MOS_ASSEMBLER_NAME "llvm-mc"
  CACHE STRING "Name of assembler program")
set(LLVM_MOS_ASSEMBLER_PATH "LLVM_MOS_ASSEMBLER_PATH-NOTFOUND"
  CACHE PATH "Location of the llvm-mos llvm-mc executable on your system")
set(LLVM_MOS_BOOTSTRAP_COMPILER OFF  
  CACHE BOOL "Build and compile the main branch of the llvm-mos compiler \
  for use by this project. Disable this if you are using a previously \
  built, local llvm-mos toolchain.")
set(LLVM_MOS_BOOTSTRAP_COMPILER_ARGS ""
  CACHE STRING "Arguments to be passed to the CMake process that bootstraps
  the llvm-mos compiler")
set(LLVM_MOS_BOOTSTRAP_COMPILER_CACHE_ARGS ""
  CACHE STRING "Arguments to be passed to the cache prior to the CMake
  process that bootstraps the llvm-mos compiler")
set(LLVM_MOS_CMAKE_MODULES_DIR ${CMAKE_MODULE_PATH}
  CACHE PATH "Path to CMake modules required to bootstrap the llvm-mos \
  compilers")
set(LLVM_MOS_GENERATE_LINK_REPORTS "ON"
  CACHE STRING "Generate detailed objdump and dwarfdump files when linking")
set(LLVM_MOS_GIT_REPOSITORY "https://www.github.com/llvm-mos/llvm-mos.git"
  CACHE STRING "The git repository from which to pull and bootstrap the 
  llvm-mos compilers")
set(LLVM_MOS_GIT_TAG "origin/main"
  CACHE STRING "Git branch name, tag, or hash from which to pull and boostrap
  the llvm-mos compilers")
set(LLVM_MOS_LINKER_COMMON_PATH "src/common/linker"
  CACHE STRING "Relative path to the common linker scripts from root")
set(LLVM_MOS_LINKER_PLATFORM_PATH "src/platform/linker"
  CACHE STRING "Relative path to the per-platform linker scripts from root")
set(LLVM_MOS_LINKER_SCRIPT_EXTENSION  ".ld"
  CACHE STRING "Extension for linker scripts")
set(LLVM_MOS_STRIPPED_EXECUTABLE_SUFFIX ".bin"
  CACHE STRING "The default suffix for stripped executables produced by \
  llvm-mos")
set(LLVM_MOS_PLATFORMS "apple2e;c64;vic20"
  CACHE STRING "A list of all targets for the SDK.")
set(LLVM_MOS_TRIPLE "mos"
  CACHE STRING "LLVM triple to use to target MOS processors")
