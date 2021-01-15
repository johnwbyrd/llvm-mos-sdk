# BootstrapCompilers.cmake
# Attempt to find and build the llvm-mos compiler, linker and assembler

include(ExternalProject)

if(LLVM_MOS_BOOTSTRAP_COMPILER)
    ExternalProject_Add( llvm-mos
        GIT_REPOSITORY ${LLVM_MOS_GIT_REPOSITORY}
        GIT_TAG ${LLVM_MOS_GIT_TAG}
        GIT_PROGRESS 1
        CMAKE_ARGS
            -C ${LLVM_MOS_CMAKE_MODULES_DIR}/llvm-mos/LLVM-cache.cmake
            <SOURCE_DIR>/llvm
            ${LLVM_MOS_BOOTSTRAP_COMPILER_ARGS}
        CMAKE_CACHE_ARGS 
            -DCMAKE_INSTALL_PREFIX:STRING=<INSTALL_DIR>/llvm-mos
            -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
            ${LLVM_MOS_BOOTSTRAP_COMPILER_CACHE_ARGS}
        TEST_COMMAND cmake --build . --target distribution
        TEST_BEFORE_INSTALL 1
        USES_TERMINAL_DOWNLOAD 1
        USES_TERMINAL_UPDATE 1
        USES_TERMINAL_CONFIGURE 1
        USES_TERMINAL_BUILD 1
        USES_TERMINAL_INSTALL 1
        USES_TERMINAL_TEST 1
    )
endif(LLVM_MOS_BOOTSTRAP_COMPILER)