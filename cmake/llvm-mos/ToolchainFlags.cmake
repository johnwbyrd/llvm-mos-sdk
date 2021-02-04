# ToolchainFlags.cmake
include_guard(GLOBAL)

string(APPEND CMAKE_ASM_FLAGS "-triple ${LLVM_MOS_TRIPLE} -filetype obj")
string(APPEND CMAKE_ASM_FLAGS_DEBUG "-g")

# Override the settings in CMakeAsmInformation.cmake
# llvm-mc does not use the -c standard
set(CMAKE_ASM_COMPILE_OBJECT
     "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_ASM_LINK_EXECUTABLE
    "${CMAKE_LINKER} <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES> -o <TARGET>")
set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES> -o <TARGET>")
set(CMAKE_CXX_LINK_EXECUTABLE ${CMAKE_C_LINK_EXECUTABLE})

set(LLVM_MOS_OBJCOPY_FLAGS --output-target binary
    CACHE STRING "Flags for stripping executables with llvm-objcopy")
