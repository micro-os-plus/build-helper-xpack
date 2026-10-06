# platforms/qemu-cortex-m0

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building Cortex-M0 application to run on the
QEMU "mps2-an385" emulated board (which is a Cortex-M3 board).

- [Application Note AN385](https://documentation-service.arm.com/static/5ed107a5ca06a95ce53f89e3)
- [DAI0385C.PDF](https://developer.arm.com/documentation/dai0385/c/DAI0385C_cortex_m3_on_v2m_mps2.pdf)

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

The `mps2-an385` machine defines:

- ZBT SSRAM 1, 0x0000_0000 – 0x003F_FFFF, 4 MiB, Primary execution memory. This is where the Cortex-M3 vector table lives at reset
- ZBT SSRAM 2&3, 0x2000_0000 – 0x203F_FFFF, 2+2 MiB, Real RAM
- PSRAM, 0x2100_0000–0x21FF_FFFF, 16 MiB

Semihosting heap base: 0x21000000, limit: 0x22000000, stack base: 0x22000000, limit: 0x21000000.

## Memory range

The applications are built for the following memory ranges:

- FLASH: 0x0000_0000-0x003F_FFFF (4 MB)
- RAM: 0x2000_0000-0x203F_FFFF (4 MB)
- stack: 0x2040_0000

## QEMU invocation

To run tests, pass the ELF file and the arguments:

```sh
qemu-system-arm --machine mps2-an385 --cpu cortex-m3 --nographic -d unimp,guest_errors --kernel "unit-test.elf" --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

For debug sessions start QEMU in GDB server mode by passing both `-s -S`:

```sh
qemu-system-arm --machine mps2-an385 --cpu cortex-m3 --nographic -d unimp,guest_errors -s -S --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

## Links

- [QEMU Arm](https://www.qemu.org/docs/master/system/target-arm.html)
- [virt](https://www.qemu.org/docs/master/system/arm/virt.html)
