# Toolchain.cmake
# Toolchain file to enable llvm-mos compilation
include_guard(GLOBAL)

include(llvm-mos/Constants)
include(llvm-mos/VerifyCompilers)
include(llvm-mos/ToolchainFlags)

# Remember the path of llvm-mc and search it in the future
get_filename_component(LLVM_MOS_TOOL_DIR ${LLVM_MOS_LLVM_MC_PATH} DIRECTORY)
set(_CMAKE_TOOLCHAIN_LOCATION ${LLVM_MOS_TOOL_DIR})
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

# We explicitly need the GNU version, which does not add in a bunch of Microsoft
# specific stuff -- Windows machines like to force this to lld-link
set(CMAKE_LINKER "${LLVM_MOS_TOOL_DIR}/lld")

set(CMAKE_ASM_COMPILE_OBJECT
     "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_ASM_LINK_EXECUTABLE
    "${CMAKE_LINKER} -flavor gnu <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

# At this point, we should know the path for most of the llvm-mos tools.
# Find llvm-ar, llvm-addr2line, etc. on that path.
include(CMakeFindBinUtils)
