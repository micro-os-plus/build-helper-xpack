# CMake Tips and tricks

Extracts from Craig Scott's "Professional CMake - A Practical Guide".

## Folders

### CMAKE_SOURCE_DIR

The top-most directory of the source tree (i.e. where the top-most CMakeLists.txt file resides).
This variable never changes its value.

### CMAKE_CURRENT_SOURCE_DIR

The directory of the CMakeLists.txt file currently being processed by CMake. It is updated each time a new file is processed as a result of an add_subdirectory() call and is restored back again when processing of that directory is complete.

### CMAKE_CURRENT_LIST_DIR

Analogous to CMAKE_CURRENT_SOURCE_DIR except it will be updated when processing the included file. This is the variable to use where the directory of the current file being processed is required, no matter how it has been added to the build. It will always hold an absolute path.

The CMAKE_CURRENT_LIST_DIR variable is generally going to be a better choice than CMAKE_CURRENT_SOURCE_DIR.

### CMAKE_CURRENT_LIST_FILE

Always gives the name of the file currently being processed. It always holds an absolute path to the file, not just the file name.

## Other

### TARGET_FILE

This will yield the absolute path and file name of the target’s binary, including any file prefix and suffix if relevant for the platform (e.g .exe, .dylib). For Unix-based platforms where shared libraries typically have version details in their file name, these will also be included.

### TARGET_FILE_NAME

Same as TARGET_FILE but without the path (i.e. it provides just the file name part).

### TARGET_FILE_DIR

Same as TARGET_FILE but without the file name. This is the most robust way to obtain the
directory in which the final executable or library is built. It’s value is different for different build configurations when using a multi configuration generator like Xcode or Visual Studio.

## Generator expressions

### `$<CONFIG>`

Evaluates to the build type. Use this in preference to the CMAKE_BUILD_TYPE variable since that variable is not used on multi configuration project generators like Xcode or Visual Studio.

### `$<PLATFORM_ID>`

Identifies the platform for which the target is being built. This can be useful in cross-compiling situations, especially where a build may support multiple platforms (e.g. device and simulator builds). This generator expression is closely related to the CMAKE_SYSTEM_NAME variable and projects should consider whether using that variable would be simpler in their specific situation.

### `$<LOWER_CASE:...>`, `$<UPPER_CASE:...>`

Any content can be converted to lower or upper case via these expressions.

## GCC With 32-bit Target On 64-bit Host

Possibly in the toolchain file:

```cmake
set(CMAKE_C_FLAGS_INIT   -m32)
set(CMAKE_CXX_FLAGS_INIT -m32)
set(CMAKE_EXE_LINKER_FLAGS_INIT -m32)
```

## Recommended Practices

When using single configuration generators like Makefiles or Ninja, consider using multiple build directories, one for each build type of interest.

Projects should generally avoid using the CMAKE_CROSSCOMPILING variable for any of its logic.
