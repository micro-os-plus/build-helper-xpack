# platforms/qemu-cortex-m7f

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building application to run on the QEMU "mps2-an500"
emulated board.

- [Application Note AN500](https://documentation-service.arm.com/static/5ed112fcca06a95ce53f8eb3)

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

The `mps2-an500` machine defines:

- ZBT SSRAM 1, 0x0000_0000 – 0x003F_FFFF, 4 MiB, Primary execution memory. This is where the Cortex-M7 vector table lives at reset
- ZBT SSRAM 2&3, 0x2000_0000 – 0x203F_FFFF, 2+2 MiB, Real RAM
- PSRAM, 0x6000_0000 - 0x60FF_FFFF, 16 MB, External PSRAM (slow, but large)

Semihosting heap base: 0x60000000, limit: 0x61000000, stack base: 0x61000000, limit: 0x60000000

## Memory range

The applications are built for the following memory ranges:

- FLASH: 0x0000_0000 - 0x003F_FFFF (4 MB)
- RAM: 0x2000_0000 - 0x203F_FFFF (4 MB)
- stack: 0x2040_0000

## QEMU invocation

To run tests, pass the ELF file and the arguments:

```sh
qemu-system-arm --machine mps2-an500 --cpu cortex-m7 --nographic -d unimp,guest_errors --kernel "unit-test.elf" --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

For debug sessions start QEMU in GDB server mode by passing both `-s -S`:

```sh
qemu-system-arm --machine mps2-an500 --cpu cortex-m7 --nographic -d unimp,guest_errors -s -S --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

## Links

- [QEMU Arm](https://www.qemu.org/docs/master/system/target-arm.html)
- [virt](https://www.qemu.org/docs/master/system/arm/virt.html)
