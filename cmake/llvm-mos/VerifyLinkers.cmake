# VerifyLinkers.cmake

# Force the setting of CMAKE_LINKER.  We explicitly need the GNU compatible version,
# which does not add in a bunch of Microsoft specific stuff -- CMake likes to force this
# to lld-link or other things.
find_program(
  LLVM_MOS_LINKER
  NAMES lld.exe lld
  HINTS ${LLVM_MOS_TOOL_DIR}
  REQUIRED)
set(CMAKE_LINKER ${LLVM_MOS_LINKER})
message(STATUS "Found linker at ${CMAKE_LINKER}")