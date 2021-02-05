llvm-mos SDK
============

Introduction
---

This is a project to develop a software development kit for practical 
MOS 6502-compatible computers.  It contains CMake source scripts,
source files, and linker files to demonstrate using the 
[llvm-mos compiler](https://www.github.com/llvm-mos/llvm-mos)
to generate ready-to-run executables for several popular 6502 targets.

To see the current list of supported targets, check out the LLVM_MOS_PLATFORMS
variable in cmake/Constants.cmake .

Requirements
---

You'll need [CMake](https://www.cmake.org) 3.10 or later.

You'll also need
the [llvm-mos compiler suite](https://github.com/llvm-mos/llvm-mos) properly 
built and installed for your machine.

You can 
[download a precompiled llvm-mos toolchain](https://github.com/llvm-mos/llvm-mos/releases),
if you want to save time.  Alternatively, security-minded folks may prefer to
roll their own llvm-mos compiler from source.

If you decide to build this toolchain locally, use the cmake/LLVM-cache.cmake
file to prime the CMake cache, in order to build a compatible llvm-mos
toolchain:

    git clone https://github.com/llvm-mos/llvm-mos
    cd llvm-mos
    mkdir build
    cd build
    cmake ../llvm \
          -C /path/to/llvm-mos/LLVM-cache.cmake \
          -DCMAKE_INSTALL_PREFIX=./install \
          -DCMAKE_BUILD_TYPE=Release
    cmake --build . --target distribution

Installation
---

To use the SDK, use CMake in a build directory to configure your project.  From
the root of this SDK:

    mkdir build
    cd build
    cmake .. 
    cmake --build .

The CMake configure step will attempt to find a working llvm-mos installation along
the path.  You can provide a hint to CMake where to find the llvm-mos
executables:

    cmake .. -D_CMAKE_TOOLCHAIN_PREFIX=/path/to/llvm-mos/build/install/bin


Directory structure
---

The `cmake` subdirectory contains CMake scripts for finding a compatible
compiler and assembler combination, and configuring it to compile the contents
of this SDK.

The `src/common` directory contains linker scripts and includable source files
that are common across multiple targets.

The `src/example` directory contains example programs which can be compiled and
run on multiple targets.

The `src/platform` directory contains per-platform linker scripts and
source code.

CMake configuration settings
---

| Name | Type | Description |
| ---  | ---  | ---         |
| `LLVM_MOS_GENERATE_LINK_REPORTS` | Boolean | Generate lots of debug information when compiling an executable, including the output of llvm-readelf, llvm-objdump, and llvm-dwarfdump. |
| `LLVM_MOS_PLATFORMS` | List | The list of 65xx platforms to be targeted in a build.  These platforms should have the same names as their MAME equivalents.

See also the CMake constants in `cmake/Constants.cmake`, which you may override
if necessary.

