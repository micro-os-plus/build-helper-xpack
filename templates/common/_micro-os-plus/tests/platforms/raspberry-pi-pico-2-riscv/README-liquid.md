# platforms/raspberry-pi-pico-2-riscv

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building Hazard3 (RISC-V) tests to run on the
Raspberry Pi Pico 2 board without the SDK.

The Pico 2 (RP2350) has two pairs of cores, dual Cortex-M33 (Arm) and dual
Hazard3 (RISC-V); this platform targets the RISC-V cores, and is otherwise
built the same way as the sibling `raspberry-pi-pico-2-arm` platform (no
Pico SDK CMake target is linked, only its header-only register
definitions are used, driving the RP2350 registers directly).

## Prerequisites

- [Raspberry Pi Pico 2 or Pico 2 with headers](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html#pico2)
- [Raspberry Pi Debug Probe](https://www.raspberrypi.com/products/debug-probe/)

The **Pico 2 with headers** is a newer version, with a small 3 pin connector soldered,
which can be directly connected to the Debug Probe, without any
custom wiring.

The **Debug Probe** is a cheap SWD (Serial Wire Debug) probe, implementing
CMSIS-DAP; for best results, this probe requires a recent OpenOCD (>= 0.12),
the current Raspberry OpenOCD fork (0.11.x) is too verbose for the use with
semihosting.

An alternate setup can be a pair of Pico's (preferably the initial model,
without the debug connector soldered) and some custom wiring, with one
Pico running the [Picoprobe](https://github.com/raspberrypi/picoprobe)
firmware.

## Include folders

The following folders should be passed to the compiler during the build:

- `include`

## Source files

- `src/hooks.cpp` — the `micro_os_plus_startup_initialise_hardware_*`
  hooks (clock bring-up); also installs the trap handler
  (`device::install_trap_handler()`, see
  [device/README.md](device/README.md)) and instantiates the
  `activity_led` (`platform::led_green`), powering it up.
- `src/led-green.cpp` — `platform::led_green` driver for the
  onboard green LED (GPIO25), implemented directly on the RP2350
  registers.

## Memory range

The applications are built for the following memory range:

- FLASH: 0x1000_0000-0x103F_FFFF (4 MB)
- RAM: 0x2000_0000-0x2007_FFFF (512 KB main SRAM)
- SCRATCH: 0x2008_0000 0x2008_1FFF (two 4 KB banks)
- stack: 0x2008_2000 (top of `SCRATCH_Y`)

## Eclipse OpenOCD launcher

Main tab
C/C++ Application: absolute path to `app.elf`

Debugger tab
OpenOCD Setup
Executable path: absolute path to `openocd`
Config options:
`-f "interface/cmsis-dap.cfg"`
`-c "adapter speed 5000"`
`-f "target/rp2350-riscv.cfg"`
GDB Client Setup
Executable path: absolute path to `riscv-none-elf-gdb`
Commands:
`set mem inaccessible-by-default off`
`set remotetimeout 4000`

Startup tab
Initialization commands
`monitor arm semihosting_cmdline test one two`
Set breakpoint at: `reset_entry`

## OpenOCD invocation

To run the tests, invoke them via OpenOCD:

```sh
openocd \
      -c "tcl port disabled" \
      -c "telnet port disabled" \
      -f "interface/cmsis-dap.cfg" \
      -c "adapter speed 5000" \
      -f "target/rp2350-riscv.cfg" \
      -c "program test.elf verify" \
      -c "arm semihosting enable" \
      -c "arm semihosting_cmdline test one two" \
      -c "reset"
```

Note the `arm semihosting ...`/`arm semihosting_cmdline ...` command names
are correct as-is, even though the target is RISC-V: OpenOCD still
registers the semihosting commands under the `arm` command group for the
Hazard3 targets (`rp2350.rv0`/`rp2350.rv1`); there is no `riscv
semihosting` command.

Unlike the sibling Arm platform, `cmake/artefacts.cmake` does not invoke
this via the `@xpack-dev-tools/openocd` xpm dependency (the one on
`xpacks/.bin/openocd`, pinned at 0.12.0-7.1, the latest published release):
that build does not yet bundle `target/rp2350-riscv.cfg`. It invokes the
Pico SDK's own OpenOCD install instead
(`~/.pico-sdk/openocd/0.12.0+dev/openocd`), the same one the VS Code debug
launcher above uses, which does have it.

## Known limitation

See [device/README.md](device/README.md) for the current status of the
RP2350 boot-ROM image metadata block.

## Links

- [Pico SDK](https://www.raspberrypi.com/documentation/pico-sdk/)
