# platforms/qemu-riscv-rv64imafdc

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building application to run on the QEMU "virt"
emulated board.

## Include folders

The following folders should be passed to the compiler during the build:

- `include`

The header files to be included in user projects are:

```cpp
#include "micro-os-plus/platform.h"
```

## Source files

The source files to be added to user projects are:

- none

## Memory range

The applications are built for the following memory range:

- RAM: 0x8000_0000-0x87FF_FFFF (128 MB)

## QEMU invocation

To run tests, pass the ELF file and the arguments:

```sh
qemu-system-riscv64 --machine virt -smp 1 -bios none --nographic -d unimp,guest_errors --kernel "unit-test.elf" --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

For debug sessions start QEMU in GDB server mode by passing both `-s -S`:

```sh
qemu-system-riscv64 --machine virt -smp 1 -bios none --nographic -d unimp,guest_errors -s -S --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

## Links

- [QEMU RISC-V](https://www.qemu.org/docs/master/system/target-riscv.html)
- [virt](https://www.qemu.org/docs/master/system/riscv/virt.html)
