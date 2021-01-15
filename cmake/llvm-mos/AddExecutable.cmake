# AddExecutable.cmake
# Functions like CMake's default add_executable, but adds a stripping stage
# to the production of the binary which can be loaded directly on the target.
include_guard(GLOBAL)

function(llvm_mos_add_executable)
    if(ARGC LESS 2)
        message(FATAL_ERROR "Too few arguments to llvm_mos_add_executable")
    endif()
    list(POP_FRONT ARGV base_name)
    foreach(platform ${LLVM_MOS_PLATFORMS})
        set(executable ${base_name}-${platform})
        add_executable(${executable} ${ARGV})
        target_link_options(${executable} 
            PUBLIC 
            -L${CMAKE_SOURCE_DIR}/${LLVM_MOS_LINKER_COMMON_PATH} 
            -L${CMAKE_SOURCE_DIR}/${LLVM_MOS_LINKER_PLATFORM_PATH}/${platform}
            -T${platform}${LLVM_MOS_LINKER_SCRIPT_EXTENSION}
            ) 
        add_custom_command(
            TARGET ${executable}
            POST_BUILD
            COMMAND ${CMAKE_OBJCOPY} ${LLVM_MOS_OBJCOPY_FLAGS}
                $<TARGET_FILE:${executable}>
                $<TARGET_FILE_DIR:${executable}>/$<TARGET_FILE_BASE_NAME:${executable}>${LLVM_MOS_STRIPPED_EXECUTABLE_SUFFIX}
        )
        # Since we're here, we can generate a ton of debugging information, if the 
        # user wants, about the link we just did.
        if(LLVM_MOS_GENERATE_LINK_REPORTS)
            add_custom_command(
                TARGET ${executable}
                POST_BUILD
                COMMAND ${CMAKE_READELF} --all
                    $<TARGET_FILE:${executable}> >
                    $<TARGET_FILE_DIR:${executable}>/$<TARGET_FILE_BASE_NAME:${executable}>.readelf
                COMMAND ${CMAKE_OBJDUMP} --all-headers --print-imm-hex -D
                    $<TARGET_FILE:${executable}> >
                    $<TARGET_FILE_DIR:${executable}>/$<TARGET_FILE_BASE_NAME:${executable}>.objdump
                COMMAND ${CMAKE_DWARFDUMP} --all -v
                    $<TARGET_FILE:${executable}> >
                    $<TARGET_FILE_DIR:${executable}>/$<TARGET_FILE_BASE_NAME:${executable}>.dwarfdump
            )
        endif()
    endforeach()
endfunction()

