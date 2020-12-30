cmake_minimum_required(VERSION 3.17)
project(llvm-mos-sdk 
  DESCRIPTION "LLVM-based SDK for the MOS 65xx series of processors"
  HOMEPAGE_URL "https://github.com/llvm-mos/llvm-mos-sdk"
  LANGUAGES C CXX ASM
)

set(CMAKE_SYSTEM_NAME "llvm-mos")
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake
  CACHE PATH "Path to CMake modules required to build ${PROJECT_NAME}")
set(LLVM_MOS_ASSEMBLER_NAME "llvm-mc"
  CACHE STRING "Name of assembler program")
set(LLVM_MOS_ASSEMBLER_DETECTION_STRING "mos"
  CACHE STRING "Word to detect in assembler --version command to prove support for llvm-mos")
set(LLVM_MOS_TRIPLE "mos"
  CACHE STRING "LLVM triple to use to target MOS processors")

# Verify that the compiler is Clang
# include(CMakeDetermineCCompiler)
if(NOT ${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
  message(FATAL_ERROR "The C compiler must be clang with MOS target support (current compiler is ${CMAKE_C_COMPILER_ID})")
endif()

# Verify that the compiler supports the MOS target
# FIXME:

# Verify that llvm-mc exists
get_filename_component(LLVM_MOS_C_COMPILER_DIR ${CMAKE_C_COMPILER} DIRECTORY)
set(LLVM_MOS_ORIIGNAL_ASM_DIR "NOTFOUND")
if (${CMAKE_ASM_COMPILER})
  get_filename_component(LLVM_MOS_ORIGINAL_ASM_DIR ${CMAKE_ASM_COMPILER} DIRECTORY)
endif()
find_program(LLVM_MOS_LLVM_MC_PATH 
  NAMES ${LLVM_MOS_ASSEMBLER_NAME}
  HINTS ${LLVM_MOS_C_COMPILER_DIR} ${LLVM_MOS_ORIGINAL_ASM_DIR}
  )
if (LLVM_MOS_LLVM_MC_PATH STREQUAL LLVM_MOS_LLVM_MC_PATH-NOTFOUND)
  message(FATAL_ERROR "Could not find ${LLVM_MOS_ASSEMBLER_NAME}; this can be built from the llvm-mos compiler distribution")
else()
  message(STATUS "Found ${LLVM_MOS_ASSEMBLER_NAME} at ${LLVM_MOS_LLVM_MC_PATH}")
endif()

# Verify that llvm-mc supports MOS as a target
execute_process(COMMAND ${LLVM_MOS_LLVM_MC_PATH} --version
                    OUTPUT_VARIABLE LLVM_MOS_LLVM_MC_VERSION_RESULT)
if (NOT ${LLVM_MOS_LLVM_MC_VERSION_RESULT} MATCHES ${LLVM_MOS_ASSEMBLER_DETECTION_STRING})
  message(FATAL_ERROR "${LLVM_MOS_ASSEMBLER_NAME} does not support MOS target; build a version that does from the llvm-mos compiler distribution" )
else()
  message(STATUS "Support for ${LLVM_MOS_ASSEMBLER_DETECTION_STRING} target detected in ${LLVM_MOS_LLVM_MC_PATH}")
endif()

# Remember the path of llvm-mc and search it in the future
get_filename_component(LLVM_MOS_TOOL_DIR ${LLVM_MOS_LLVM_MC_PATH} DIRECTORY)
list(APPEND CMAKE_PROGRAM_PATH ${LLVM_MOS_TOOL_DIR})
# If there's a bin directory in the build directory, throw that in as well
list(APPEND CMAKE_PROGRAM_PATH ${CMAKE_BINARY_DIR}/bin)
list(REMOVE_DUPLICATES CMAKE_PROGRAM_PATH)

set(CMAKE_ASM_COMPILER_ID ${LLVM_MOS_ASSEMBLER_NAME})
set(CMAKE_ASM_COMPILER ${LLVM_MOS_LLVM_MC_PATH})

list(APPEND CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDORS llvm-mc )
set(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDOR_FLAGS_Clang "--version")
set(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDOR_REGEX_Clang "(llvm-mc version)")

include(CMakeDetermineASMCompiler)

function(llvm_mos_set_env name value)
    find_program(
        LLVM_MOS_TOOL_PATH_${name}
        ${value}
        HINTS ${LLVM_MOS_TOOL_DIR} ${CMAKE_PROGRAM_PATH}
        NO_DEFAULT_PATH
        REQUIRED
     )
    set(${name} ${LLVM_MOS_TOOL_PATH_${name}} PARENT_SCOPE CACHE PATH )
endfunction()

if(false)
llvm_mos_set_env(CMAKE_ADDR2LINE llvm-addr2line)
llvm_mos_set_env(CMAKE_ASM_COMPILER llvm-mc)
llvm_mos_set_env(CMAKE_ASM_COMPILER_AR llvm-ar)
llvm_mos_set_env(CMAKE_AR llvm-ar)
llvm_mos_set_env(CMAKE_C_COMPILER clang)
llvm_mos_set_env(CMAKE_CXX_COMPILER clang++)
llvm_mos_set_env(CMAKE_DLLTOOL llvm-dlltool)
llvm_mos_set_env(CMAKE_LINKER lld)
llvm_mos_set_env(CMAKE_MT llvm-mt)
llvm_mos_set_env(CMAKE_NM llvm-nm)
llvm_mos_set_env(CMAKE_READELF llvm-readelf)
llvm_mos_set_env(CMAKE_OBJCOPY llvm-objcopy)
llvm_mos_set_env(CMAKE_OBJDUMP llvm-objdump)
llvm_mos_set_env(CMAKE_RANLIB llvm-ranlib)
llvm_mos_set_env(CMAKE_RC llvm-rc)
llvm_mos_set_env(CMAKE_STRIP llvm-strip)
endif()

set(CMAKE_LINKER "${LLVM_MOS_TOOL_DIR}/lld")

set(_CMAKE_TOOLCHAIN_LOCATION ${LLVM_MOS_TOOL_DIR})

set(CMAKE_ASM_COMPILE_OBJECT
     "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_ASM_LINK_EXECUTABLE
    "${CMAKE_LINKER} -flavor gnu <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# At this point, we should know the path for most of the llvm-mos tools.
# Find llvm-ar, llvm-addr2line, etc. on that path.
include(CMakeFindBinUtils)
string(APPEND CMAKE_ASM_FLAGS "-triple ${LLVM_MOS_TRIPLE} -filetype obj")
string(APPEND CMAKE_ASM_DEBUG_FLAGS_INIT "-g")

macro(print_all_variables)
    message(STATUS "print_all_variables------------------------------------------{")
    get_cmake_property(_variableNames VARIABLES)
    foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
    message(STATUS "print_all_variables------------------------------------------}")
endmacro()

# print_all_variables()

add_subdirectory(src)
