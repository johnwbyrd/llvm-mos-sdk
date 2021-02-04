# AddLibrary.cmake
# Functions like CMake's default add_library, but adds some include
# directories to the target.
include_guard(GLOBAL)

function(llvm_mos_add_library)
    if(ARGC LESS 2)
        message(FATAL_ERROR "Too few arguments to llvm_mos_add_library")
    endif()
    list(POP_FRONT ARGV base_name)
    set(library ${base_name})
    add_library(${library} ${ARGV})
    target_include_directories(${library} 
        PUBLIC "${CMAKE_SOURCE_DIR}/${LLVM_MOS_SOURCE_COMMON_LIBRARY_PATH}")
    # Only generate a link report if this is not an object-only library
    # AND we were asked to generate them
    if(LLVM_MOS_GENERATE_LINK_REPORTS AND (NOT OBJECT IN_LIST ARGV))
        add_custom_command(
            TARGET ${library}
            POST_BUILD
            COMMAND ${CMAKE_READELF} --all
                $<TARGET_FILE:${library}> >
                $<TARGET_FILE_DIR:${library}>/$<TARGET_FILE_BASE_NAME:${library}>.readelf
            COMMAND ${CMAKE_OBJDUMP} --all-headers --print-imm-hex -D
                $<TARGET_FILE:${library}> >
                $<TARGET_FILE_DIR:${library}>/$<TARGET_FILE_BASE_NAME:${library}>.objdump
            COMMAND ${CMAKE_DWARFDUMP} --all -v
                $<TARGET_FILE:${library}> >
                $<TARGET_FILE_DIR:${library}>/$<TARGET_FILE_BASE_NAME:${library}>.dwarfdump
    )
    endif() # LLVM_MOS_GENERATE_LINK_REPORTS
endfunction()

