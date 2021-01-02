# ToolchainFlags.cmake
include_guard(GLOBAL)

string(APPEND CMAKE_ASM_FLAGS "-triple ${LLVM_MOS_TRIPLE} -filetype obj")
string(APPEND CMAKE_ASM_FLAGS_DEBUG "-g")

set(CMAKE_ASM_COMPILE_OBJECT
     "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_ASM_LINK_EXECUTABLE
    "${CMAKE_LINKER} -flavor gnu <LINK_FLAGS> <OBJECTS> -o <TARGET> \
        <LINK_LIBRARIES>")
set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> \
        -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> \
        -o <TARGET> <LINK_LIBRARIES>")
set(LLVM_MOS_OBJCOPY_FLAGS --output-target binary --strip-unneeded
    CACHE STRING "Flags for stripping executables with llvm-objcopy")
