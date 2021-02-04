foreach(platform ${LLVM_MOS_PLATFORMS})
    add_subdirectory(${platform})
endforeach()