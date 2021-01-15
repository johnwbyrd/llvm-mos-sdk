# Toolchain.cmake
# Toolchain file to enable llvm-mos compilation
include_guard(GLOBAL)

include(llvm-mos/Constants)
# Now that constants are set, we can bootstrap the local compilers
include(llvm-mos/BootstrapCompilers)
include(llvm-mos/VerifyCompilers)
include(llvm-mos/ToolchainFlags)
include(llvm-mos/AddExecutable)

# Remember the path of llvm-mc and search it in the future
get_filename_component(LLVM_MOS_TOOL_DIR_EXTRACTED ${LLVM_MOS_ASSEMBLER_PATH} DIRECTORY)
set(LLVM_MOS_TOOL_DIR ${LLVM_MOS_TOOL_DIR_EXTRACTED}
  CACHE PATH "Path to Clang and LLVM tools with MOS target support")

# We delay searching for the linker until this point, because the search depends on
# LLVM_MOS_TOOL_DIR
include(llvm-mos/VerifyLinkers)

set(_CMAKE_TOOLCHAIN_LOCATION ${LLVM_MOS_TOOL_DIR})
list(APPEND CMAKE_PROGRAM_PATH ${LLVM_MOS_TOOL_DIR})
# If there's a bin directory in the build directory, throw that in as well
list(APPEND CMAKE_PROGRAM_PATH ${CMAKE_BINARY_DIR}/bin)
list(REMOVE_DUPLICATES CMAKE_PROGRAM_PATH)

set(CMAKE_ASM_COMPILER_ID ${LLVM_MOS_ASSEMBLER_NAME})
set(CMAKE_ASM_COMPILER ${LLVM_MOS_ASSEMBLER_PATH})

list(APPEND CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDORS llvm-mc )
set(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDOR_FLAGS_Clang "--version")
set(CMAKE_ASM${ASM_DIALECT}_COMPILER_ID_VENDOR_REGEX_Clang "(llvm-mc version)")

include(CMakeDetermineASMCompiler)

# At this point, we should know the path for most of the llvm-mos tools.
# Find llvm-ar, llvm-addr2line, etc. on that path.
include(CMakeFindBinUtils)

# For some reason, the CMakeFindBinUtils logic doesn't look for llvm-dwarfdump
find_program(
    LLVM_MOS_DWARFDUMP 
    NAMES llvm-dwarfdump
    HINTS ${LLVM_MOS_TOOL_DIR}
    )
set(CMAKE_DWARFDUMP ${LLVM_MOS_DWARFDUMP}
    CACHE PATH "Path to llvm-dwarfdump utility with llvm-mos support")
