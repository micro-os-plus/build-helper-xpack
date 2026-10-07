# platforms/qemu-cortex-m33

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building Cortex-M33 application to run on the
QEMU "mps2-an505" emulated board (which is a Cortex-M33 board).

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

The `mps2-an505` machine defines:

- SSRAM-0, 0x0000_0000 – 0x003F_FFFF, 4 MiB, Primary execution memory. This is where the CPU vector table lives at reset
- SSRAM 2&3, 0x2800_0000 – 0x283F_FFFF, 2+2 MiB, Additional on-chip SRAM
- System RAM, 0x8000_0000 - 0x80FF_FFFF, 16 MB, The largest contiguous block of RAM

Semihosting heap base: 0x80000000, limit: 0x81000000, stack base: 0x81000000, limit: 0x80000000.

## Memory range

The applications are built for the following memory ranges:

- FLASH: 0x1000_0000-0x101F_FFFF (2 MB)
- RAM: 0x1020_0000-0x103F_FFFF (2 MB)
- stack: 0x1040_0000

## QEMU invocation

To run tests, pass the ELF file and the arguments:

```sh
qemu-system-arm --machine mps2-an505 --cpu cortex-m33 --nographic -d unimp,guest_errors --kernel "unit-test.elf" --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

For debug sessions start QEMU in GDB server mode by passing both `-s -S`:

```sh
qemu-system-arm --machine mps2-an505 --cpu cortex-m33 --nographic -d unimp,guest_errors -s -S --semihosting-config enable=on,target=native,arg=unit-test,arg=--reporter,arg=human
```

## Links

- [QEMU Arm](https://www.qemu.org/docs/master/system/target-arm.html)
- [Arm MPS2 and MPS3 boards](https://www.qemu.org/docs/master/system/arm/mps2.html)
- [CMSIS-Zone](https://arm-software.github.io/CMSIS_5/Zone/html/index.html)
- [Cortex-M33 IoT Subsystem FPGA image for the V2M-MPS2+ prototyping platform](https://github.com/Introduction-To-System-On-Chip/QEMU_an505)

Arm Application Note AN505 defines the
[Cortex-M33 IoT Subsystem FPGA image for the V2M-MPS2+ prototyping platform](https://github.com/Introduction-To-System-On-Chip/QEMU_an505),
serving as a reference for evaluating Armv8-M TrustZone technology.

The specification, which outlines a processor core with Secure and
Non-Secure memory mapping, is widely supported in QEMU, Arm Virtual
Hardware, and the Zephyr RTOS, facilitating development without physical
hardware.

Detailed technical specifications and source files are available
at the [Arm AN505 Download Page](https://support.arm.com/downloads/view/AN505).
