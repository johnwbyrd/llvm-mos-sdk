# VerifyCompilers.cmake
# Make sure that the compilers we've found work OK with the llvm-mos SDK
include_guard(GLOBAL)

# Verify that the compiler is Clang
# include(CMakeDetermineCCompiler)
if(NOT ${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
  message(FATAL_ERROR "The C compiler must be clang with MOS target support \
  (current compiler is ${CMAKE_C_COMPILER_ID}). \
  Reconfigure with the CMAKE_C_COMPILER CMake settings \
  pointing to the llvm-mos versions.")
endif()

# Verify that the Clang compiler supports the MOS target
# TODO

# Verify that llvm-mc exists
get_filename_component(LLVM_MOS_C_COMPILER_DIR ${CMAKE_C_COMPILER} DIRECTORY)
set(LLVM_MOS_ORIGINAL_ASM_DIR "NOTFOUND")
if (${CMAKE_ASM_COMPILER})
  get_filename_component(LLVM_MOS_ORIGINAL_ASM_DIR ${CMAKE_ASM_COMPILER} DIRECTORY)
endif()
find_program(LLVM_MOS_LLVM_MC_PATH 
  NAMES ${LLVM_MOS_ASSEMBLER_NAME}
  HINTS ${LLVM_MOS_C_COMPILER_DIR} ${LLVM_MOS_ORIGINAL_ASM_DIR}
  )
if (LLVM_MOS_LLVM_MC_PATH STREQUAL LLVM_MOS_LLVM_MC_PATH-NOTFOUND)
  message(FATAL_ERROR "Could not find ${LLVM_MOS_ASSEMBLER_NAME}; \
    this can be built from the llvm-mos compiler distribution")
else()
  message(STATUS "Found ${LLVM_MOS_ASSEMBLER_NAME} at ${LLVM_MOS_LLVM_MC_PATH}")
endif()

# Verify that llvm-mc supports MOS as a target
execute_process(COMMAND ${LLVM_MOS_LLVM_MC_PATH} --version
                    OUTPUT_VARIABLE LLVM_MOS_LLVM_MC_VERSION_RESULT)
if (NOT ${LLVM_MOS_LLVM_MC_VERSION_RESULT} MATCHES ${LLVM_MOS_ASSEMBLER_DETECTION_STRING})
  message(FATAL_ERROR 
    "${LLVM_MOS_ASSEMBLER_NAME} does not support MOS target; build a version \
    that does from the llvm-mos compiler distribution" )
else()
  message(STATUS 
    "Support for ${LLVM_MOS_ASSEMBLER_DETECTION_STRING} target detected \
    in ${LLVM_MOS_LLVM_MC_PATH}")
endif()