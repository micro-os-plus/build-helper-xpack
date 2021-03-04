# Compiler Warnings

The general recommandation is to try to compile with as many warnings checks
enabled, and explicitly disable some warnings where needed.

Enabling all warnings for GCC is a bit more complicated, so the minimum
recomended would be to pass the build with clang `-Wall -Weverything`.

## GCC

From GCC 10 manual:

### `-Wall`

This option turns on the following warning flags:

- `-Waddress`
- `-Warray-bounds=1` (only with ‘-O2’)
- `-Wbool-compare`
- `-Wbool-operation`
- `-Wc++11-compat`
- `-Wc++14-compat`
- `-Wcatch-value` (C++ and Objective-C++ only)
- `-Wchar-subscripts`
- `-Wcomment`
- `-Wduplicate-decl-specifier` (C and Objective-C only)
- `-Wenum-compare` (in C/ObjC; this is on by default in C++)
- `-Wenum-conversion` in C/ObjC;
- `-Wformat`
- `-Wformat-overflow`
- `-Wformat-truncation`
- `-Wint-in-bool-context`
- `-Wimplicit` (C and Objective-C only)
- `-Wimplicit-int` (C and Objective-C only)
- `-Wimplicit-function-declaration` (C and Objective-C only)
- `-Winit-self` (only for C++)
- `-Wlogical-not-parentheses`
- `-Wmain` (only for C/ObjC and unless ‘-ffreestanding’)
- `-Wmaybe-uninitialized`
- `-Wmemset-elt-size`
- `-Wmemset-transposed-args`
- `-Wmisleading-indentation` (only for C/C++)
- `-Wmissing-attributes`
- `-Wmissing-braces` (only for C/ObjC)
- `-Wmultistatement-macros`
- `-Wnarrowing` (only for C++)
- `-Wnonnull`
- `-Wnonnull-compare`
- `-Wopenmp-simd`
- `-Wparentheses`
- `-Wpessimizing-move` (only for C++)
- `-Wpointer-sign`
- `-Wreorder`
- `-Wrestrict`
- `-Wreturn-type`
- `-Wsequence-point`
- `-Wsign-compare` (only in C++)
- `-Wsizeof-pointer-div`
- `-Wsizeof-pointer-memaccess`
- `-Wstrict-aliasing`
- `-Wstrict-overflow=1`
- `-Wswitch`
- `-Wtautological-compare`
- `-Wtrigraphs`
- `-Wuninitialized`
- `-Wunknown-pragmas`
- `-Wunused-function`
- `-Wunused-label`
- `-Wunused-value`
- `-Wunused-variable`
- `-Wvolatile-register-var`
- `-Wzero-length-bounds`

### `-Wextra`

This enables some extra warning flags that are not enabled by ‘-Wall’.

- `-Wclobbered`
- `-Wcast-function-type`
- `-Wdeprecated-copy` (C++ only)
- `-Wempty-body`
- `-Wignored-qualifiers`
- `-Wimplicit-fallthrough=3` ((__attribute__ ((fallthrough));))
- `-Wmissing-field-initializers`
- `-Wmissing-parameter-type` (C only)
- `-Wold-style-declaration` (C only)
- `-Woverride-init`
- `-Wsign-compare` (C only)
- `-Wstring-compare`
- `-Wredundant-move` (only for C++)
- `-Wtype-limits`
- `-Wuninitialized`
- `-Wshift-negative-value` (in C++03 and in C99 and newer)
- `-Wunused-parameter` (only with ‘-Wunused’ or ‘-Wall’)
- `-Wunused-but-set-parameter` (only with ‘-Wunused’ or ‘-Wall’)

### Other

- `-Wdouble-promotion` (C, C++, Objective-C and Objective-C++ only)
- `-Wduplicate-decl-specifier` (C and Objective-C only)
- `-Wformat=2`
- `-Wformat-overflow=2`
- `-Wformat-nonliteral`
- `-Wformat-security`
- `-Wformat-signedness`
- `-Wformat-truncation=2`
- `-Wformat-y2k`
- `-Wnull-dereference`
- `-Wmissing-include-dirs`
- `-Wshift-overflow=2`
- `-Wswitch-default`
- `-Wswitch-enum`
- `-Wuninitialized`
- `-Warith-conversion`
- `-Wduplicated-branches`
- `-Wduplicated-cond`
- `-Wfloat-equal`
- `-Wshadow`
- `-Wpointer-arith`
- `-Wundef`
- `-Wbad-function-cast` (C and Objective-C only)
- `-Wc++-compat` (C and Objective-C only)
- `-Wcast-qual`
- `-Wcast-align`
- `-Wconversion`
- `-Wfloat-conversion`
- `-Wsign-conversion`
- `-Wlogical-op`
- `-Waggregate-return`
- `-Wstrict-prototypes` (C and Objective-C only)
- `-Wold-style-definition`
- `-Wmissing-prototypes` (C and Objective-C only)
- `-Wmissing-declarations`
- `-Wpacked`
- `-Wpadded`
- `-Wredundant-decls`
- `-Wnested-externs` (C and Objective-C only)
- `-Wvla`

And for C++

- `-Wabi-tag` (C++ and Objective-C++ only)
- `-Wcomma-subscript` (C++ and Objective-C++ only)
- `-Wctor-dtor-privacy` (C++ and Objective-C++ only)
- `-Wnoexcept` (C++ and Objective-C++ only)
- `-Wnon-virtual-dtor` (C++ and Objective-C++ only)
- `-Wregister` (C++ and Objective-C++ only)
- `-Wredundant-tags` (C++ and Objective-C++ only)
- `-Wstrict-null-sentinel` (C++ and Objective-C++ only)
- `-Wold-style-cast` (C++ and Objective-C++ only)
- `-Woverloaded-virtual` (C++ and Objective-C++ only)
- `-Wsign-promo` (C++ and Objective-C++ only)
- `-Wmismatched-tags` (C++ and Objective-C++ only)
- `-Wvolatile` (C++ and Objective-C++ only)
- `-Wzero-as-null-pointer-constant` (C++ and Objective-C++ only)
- `-Wplacement-new=2` (C++, Objective-C++ only)
- `-Wextra-semi` (C++, Objective-C++ only)
- `-Wsuggest-final-types`
- `-Wsuggest-final-methods`
- `-Wsuggest-override`
- `-Wuseless-cast` (C++ and Objective-C++ only)

### Silencing GCC warnings

Silencing GCC warnings is strightforward:

```c
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

#pragma GCC diagnostic pop
```

## clang

For clang things are easier, to enable all possible checks use:

- `-Wall`
- `-Weverything`

### Silencing clang warnings

There are many common warnings with GCC, and silencing them with `#pragma GCC`
is ok, but there are several clang specific warnings, that need conditional
compiling like:

```c
#pragma GCC diagnostic push
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wc++98-compat"
#endif

#pragma GCC diagnostic pop
```
