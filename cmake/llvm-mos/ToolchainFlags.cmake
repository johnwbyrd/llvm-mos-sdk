# ToolchainFlags.cmake
include_guard(GLOBAL)

string(APPEND CMAKE_ASM_FLAGS "-triple ${LLVM_MOS_TRIPLE} -filetype obj")
string(APPEND CMAKE_ASM_DEBUG_FLAGS_INIT "-g")