set(LLVM_MOS_TRIPLE mos)
set(CMAKE_ASM_COMPILER_TARGET ${LLVM_MOS_TRIPLE})
set(CMAKE_C_COMPILER_TARGET ${LLVM_MOS_TRIPLE})
set(CMAKE_CXX_COMPILER_TARGET ${LLVM_MOS_TRIPLE})

function(llvm_mos_set_env name value)
    find_program(
        LLVM_MOS_TOOL_PATH_${name}
        ${value}
        HINTS ${LLVM_MOS_BINARY_DIR}
        NO_DEFAULT_PATH
        REQUIRED
     )
    set(${name} ${LLVM_MOS_TOOL_PATH_${name}} PARENT_SCOPE )
endfunction()

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

set(CMAKE_ASM_COMPILER_ID "llvm-mc")
set(CMAKE_ASM_FLAGS_INIT " ")

set(_CMAKE_TOOLCHAIN_LOCATION ${LLVM_MOS_BINARY_DIR})

set(CMAKE_ASM_COMPILE_OBJECT
     "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_C_LINK_EXECUTABLE
     "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

include(CMakeDetermineASMCompiler)
include(CMakeFindBinUtils)

string(APPEND CMAKE_ASM_FLAGS "-triple mos -filetype obj")
string(APPEND CMAKE_ASM_DEBUG_FLAGS "-g")

macro(print_all_variables)
    message(STATUS "print_all_variables------------------------------------------{")
    get_cmake_property(_variableNames VARIABLES)
    foreach (_variableName ${_variableNames})
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
    message(STATUS "print_all_variables------------------------------------------}")
endmacro()

print_all_variables()

