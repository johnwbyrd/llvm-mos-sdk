llvm-mos SDK
============

Introduction
---

This is a project to develop a C compiler, assembler, and related
tools and libraries for 8-bit machines using the MOS 6502 microprocessor, as 
well as close variants of that microprocessor.

Requirements
---

You'll need [CMake](https://www.cmake.org) 3.10 or later.

You'll also need
the [llvm-mos compiler suite](https://github.com/llvm-mos/llvm-mos) installed. 
You can [download a precompiled toolchain](https://github.com/llvm-mos/llvm-mos/releases),
if you want to save time; or, you can bootstrap the llvm-mos compiler yourself,
as part of building this SDK.

You can set up your llvm-mos compiler suite along the PATH of your machine,
or you cam provide the CMAKE_C_COMPILER flag to cmake, along with the path
to the llvm-mos C compiler.  A non-limiting example:

    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=[path-to-llvm-mos-clang] -S [root-of-this-sdk] -B [build-directory]

CMake configuration settings
---

| Name | Type | Description |
| ---  | ---  | ---         |
| `LLVM_BOOTSTRAP_COMPILER` | Boolean | If you have not installed the llvm-mos compilation tools on your platform, this SDK will attempt to download and build them for you, if you set this value to ON prior to CMake configuration. They will be present in your build/llvm-mos-prefix/llvm-mos directory after bootstrapping. |
| `LLVM_MOS_TOOL_DIR` | Path | If you have already downloaded the llvm-mos compiler suite, you can inform this SDK where to find it, by setting this CMake variable to the directory where the llvm-mos compiler toolchain is installed. |
| `LLVM_MOS_GENERATE_LINK_REPORTS` | Boolean | Generate lots of debug information when compiling an executable, including the output of llvm-readelf, llvm-objdump, and llvm-dwarfdump. |
| `LLVM_MOS_PLATFORMS` | List | The list of 65xx platforms to be targeted in a build.  These platforms should have the same names as their MAME equivalents.

See also the CMake constants in `cmake/Constants.cmake`, which you may override
if necessary.



Bootstrapping your own compiler
---

If you don't trust our binaries, you can build your own local version of the 
[llvm-mos toolchain](https://github.com/llvm-mos/llvm-mos).  To do this,
set the CMakae flag LLVM_MOS_BOOTSTRAP_COMPILER to ON before configuring CMake.  Then, build 
the project.  You should have a new compiler in your build directory at
src/llvm-mos-compiler-prefix/src/llvm-mos-compiler-build/bin.  Then, rebuild
your project while setting LLVM_MOS_BOOTSTRAP_COMPILER to OFF.

If you decide to build the llvm-mos toolchain yourself, 
look to `cmake\LLVM-cache.cmake` for the cache file that you should provide to
CMake, when you build your own binaries of llvm-mos.  In general, provide that
file with the -C option to cmake when building the llvm-mos toolchain, in order
to create binaries that are usable with this SDK.
