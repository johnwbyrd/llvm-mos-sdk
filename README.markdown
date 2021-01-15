llvm-mos SDK
============

Introduction
---

This is an experimental project to develop a C compiler, assembler, and related
tools and libraries for 8-bit machines using the MOS 6502 microprocessor, as 
well as close variants of that microprocessor.

Requirements
---

You'll need [CMake](https://www.cmake.org) 3.17 or later.  You will also need
the [llvm-mos compiler suite](https://github.com/llvm-mos/llvm-mos) installed. 
You can [download a precompiled toolchain](https://github.com/llvm-mos/llvm-mos/releases), or you can build your .


CMake configuration settings
---

| Name | Type | Description |
| ---  | ---  | ---         |
| `LLVM_BOOTSTRAP_COMPILER` | Boolean | If you have not installed the llvm-mos compilation tools on your platform, this SDK will attempt to download and build them for you, if you set this value to ON prior to CMake configuration. |
| `LLVM_MOS_TOOL_DIR` | Path | If you have already downloaded the llvm-mos compiler suite, you can inform this SDK where to find it, by setting this CMake variable to the directory where the llvm-mos compiler toolchain is installed. |
| `LLVM_MOS_GENERATE_LINK_REPORTS` | Boolean | Generate lots of debug information when compiling an executable, including the output of llvm-readelf, llvm-objdump, and llvm-dwarfdump. |

See also the CMake constants in `cmake/Constants.cmake`, which you may override
if necessary.

Bootstrapping your own compiler
---

If you don't trust our binaries, you can build your own local version of the 
[llvm-mos toolchain](https://github.com/llvm-mos/llvm-mo).

If you decide to build the llvm-mos toolchain yourself, 
look to `cmake\LLVM-cache.cmake` for the cache file that you should provide to
CMake, when you build your own binaries of llvm-mos.  In general, provide that
file with the -C option to cmake when building the llvm-mos toolchain, in order
to create binaries that are usable with this SDK.
