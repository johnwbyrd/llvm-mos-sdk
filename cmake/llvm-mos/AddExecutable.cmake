# AddExecutable.cmake
# Functions like CMake's default add_executable, but adds a stripping stage
# to the production of the binary which can be loaded directly on the target.
include_guard(GLOBAL)

function(llvm_mos_add_executable)
    if(ARGC LESS 2)
        message(FATAL_ERROR "Too few arguments to llvm_mos_add_executable")
    endif()
    list(POP_FRONT ARGV base_name)
    add_executable(${base_name} ${ARGV})
    add_custom_command(
        TARGET ${base_name}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} ${LLVM_MOS_OBJCOPY_FLAGS}
            $<TARGET_FILE:${base_name}>
            $<TARGET_FILE_DIR:${base_name}>/$<TARGET_FILE_BASE_NAME:${base_name}>${LLVM_MOS_STRIPPED_EXECUTABLE_SUFFIX}
    )
endfunction()

