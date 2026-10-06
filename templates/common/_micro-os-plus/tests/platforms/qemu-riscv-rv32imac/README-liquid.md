# platforms/qemu-riscv-rv32imac

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

## Memory map

The `virt` machine defines:

- pflash0/1, 0x2000_0000, 2 × 32 MiB, CFI parallel NOR flash
- RAM region 0x80000000 (1 GiB), with the actual value as given by `-m`, 128 MiB if mising.

Semihosting heap base: 0x80037398, limit: 0x87e00000, stack base: 0x87e00000, limit: 0x80037398

## Memory range

The applications are built for the following memory ranges:

- FLASH: 0x8000_0000 - 0x83FF_FFFF (64 MB)
- RAM: 0x8400_0000 - 0x87FF_FFFF (64 MB)
- stack: 0x8800_0000

## QEMU invocation

To run tests, pass the ELF file and the arguments:

```sh
qemu-system-riscv32 --machine virt -smp 1 -bios none --nographic -d unimp,guest_errors --kernel "unit-test.elf" --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

For debug sessions start QEMU in GDB server mode by passing both `-s -S`:

```sh
qemu-system-riscv32 --machine virt -smp 1 -bios none --nographic -d unimp,guest_errors -s -S --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

## Links

- [QEMU RISC-V](https://www.qemu.org/docs/master/system/target-riscv.html)
- [virt](https://www.qemu.org/docs/master/system/riscv/virt.html)
