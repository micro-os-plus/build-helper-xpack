# README

## Generator expressions

```cmake
$<$<PLATFORM_ID:Darwin>:-Wno-xxx>
$<$<PLATFORM_ID:Linux>:-Wno-xxx>
$<$<PLATFORM_ID:Windows>:-Wno-xxx>
```

```cmake
$<$<C_COMPILER_ID:Clang,AppleClang>:-Wno-xxx>
$<$<C_COMPILER_ID:GNU>:-Wno-xxx>
```

```cmake
$<$<CONFIG:Release>::-Wno-xxx>
$<$<CONFIG:MinSizeRel>::-Wno-xxx>
$<$<CONFIG:Debug>::-Wno-xxx>
```

```cmake
$<$<COMPILE_LANGUAGE:C>:-fxxx>
$<$<COMPILE_LANGUAGE:CXX>:-fxxx>
```
