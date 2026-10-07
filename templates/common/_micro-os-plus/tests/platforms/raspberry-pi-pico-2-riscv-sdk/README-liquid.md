# platforms/raspberry-pi-pico-2-riscv-sdk

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Support files for building Hazard3 (RISC-V) tests to run on the
Raspberry Pi Pico 2 board with the
[Pico SDK](https://www.raspberrypi.com/documentation/pico-sdk/).

The Pico 2 (RP2350) has two pairs of cores, dual Cortex-M33 (Arm) and dual
Hazard3 (RISC-V); this platform targets the RISC-V cores, and is otherwise
built the same way as the sibling `raspberry-pi-pico-2-arm-sdk` platform
(on top of the vendor Pico SDK's own crt0/runtime, rather than driving the
RP2350 registers directly).

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

If the board was last flashed with an Arm image (or is otherwise not
already running RISC-V firmware), OpenOCD's own `target/rp2350-riscv.cfg`
notes that each Hazard3 core "must already be selected", for example via
`picotool reboot -u -c riscv`, before it can be examined; this has not
been necessary in practice with the `program ... verify` / `reset` flow
used here (which flashes a RISC-V-declared boot image), but is worth
knowing if a session fails to attach to the RISC-V cores.

## Include folders

The following folders should be passed to the compiler during the build:

- `include`

## Pico SDK integration

This platform is intended for CI and automated testing, and behaves like
the other µOS++ test platforms; the Pico SDK is used only for what is
specific to the RP2350 (Hazard3 RISC-V cores).

- **µOS++ owns everything from the C library down**: the newlib
  syscalls (`_write()`, `_read()`, etc., over semihosting), `exit()`/
  `_exit()` (reporting the exit code to the host via semihosting),
  the startup sequence, and the heap (`_sbrk()`, from the
  `devices-raspberry-pi` package, enabled by
  `MICRO_OS_PLUS_DEVICES_RASPBERRY_PI_SDK_SBRK_ENABLED`; it grows from
  `end` to `__StackLimit`, as defined by the SDK linker script).
- **The Pico SDK provides** only the boot image and the linker script
  (`pico_standard_link`), the reset entry (`pico_crt0`), the platform
  and runtime initialisers (`pico_platform`, `pico_runtime_init`),
  and the hardware drivers (`hardware_clocks`, `hardware_gpio`,
  `hardware_hazard3`).
- **`pico_stdlib` and `pico_runtime` must not be linked.** They bring in
  `pico_clib_interface`, `pico_stdio`, `pico_printf`, and `pico_malloc`,
  which redefine or `--wrap` the newlib syscalls, `exit()`/`_exit()`,
  `printf()`/`puts()`/`vsnprintf()`, and `malloc()`. The result is
  either a link failure (duplicate `exit()`) or, worse, silent
  misbehaviour: both `_exit()` implementations are weak, and the SDK
  one is picked by link order, so the exit code never reaches the host;
  and the test output goes to the UART instead of semihosting.

  The SDK offers no way to keep `pico_stdlib` without these libraries:
  `pico_minimize_runtime()` controls only printf, floating point, panic,
  mutex, and thread-local support, not `pico_clib_interface` or
  `pico_stdio`. Therefore the platform links an explicit list of SDK
  targets instead, and `src/wraps.c` defines link-time tripwires that
  fail the build if the unwanted libraries return.

The start-up sequence is:

1. `pico_crt0` calls `runtime_init()`, which, without `pico_runtime`,
   is only the empty weak stub in `crt0`, then calls `main()`, wrapped
   to `__wrap_main()`.
2. `__wrap_main()` initialises the Hazard3 interrupt registers
   (`runtime_init_per_core_h3_irq_registers()`), then calls
   `micro_os_plus_startup_run_main()`.
3. `micro_os_plus_startup_initialise_hardware_hook()` calls the first SDK
   hardware initialisers, in the SDK order: the bootrom state resets, the
   early resets, the USB power down, the clocks, and the post-clock
   resets. They are excluded from `__preinit_array` (via the
   `PICO_RUNTIME_SKIP_INIT_*` definitions in `CMakeLists.txt`), so they
   run only once. The clocks are then available, and the hook reports the
   system clock frequency right after the CPU identification.
4. `micro_os_plus_run_init_array()` runs the `__preinit_array`, where the
   linked SDK libraries register the remaining runtime initialisers (via
   `PICO_RUNTIME_INIT_FUNC*()`), in the SDK order: spin and boot locks,
   bootrom locking, mutexes, the Hazard3 interrupt registers (a second,
   harmless, time), IRQ priorities, etc. The default alarm pool is
   disabled (`PICO_TIME_DEFAULT_ALARM_POOL_DISABLED`, see
   `CMakeLists.txt`). They run before the C++ static constructors in
   `__init_array`.
5. `micro_os_plus_startup_post_init_array_hook()` runs, with the
   hardware fully initialised, then `main()`.

## Source files

- `src/wraps.c` — `__wrap_main()`, the application entry point called
  by `pico_crt0` (via `-Wl,--wrap=main`), which initialises the Hazard3
  interrupt registers and continues with the µOS++ startup code, as
  described above; and a
  no-op replacement for `__libc_init_array()` (via
  `-Wl,--wrap=__libc_init_array`), so that, should any code call it,
  the static constructors are not run twice, since they are already run
  by `micro_os_plus_startup_run_main()` right before `main()`. It also
  defines link-time tripwires (`__wrap_printf()`, `__wrap_vsnprintf()`,
  `__wrap_malloc()`), which make the link fail with a
  `multiple definition` error if `pico_stdio`, `pico_printf`, or
  `pico_malloc` are ever linked again; they are otherwise discarded by
  `--gc-sections`.
- `src/hooks.cpp` — the µOS++ startup hooks, called from
  `micro_os_plus_startup_run_main()`/`exit()`:
  - `micro_os_plus_startup_initialise_hardware_hook()`, which calls
    the first SDK hardware initialisers, up to the clocks (see above),
    and reports the system clock frequency (`clock_get_hz (clk_sys)`);
    the remaining SDK initialisers and the static constructors have not
    run yet at this point;
  - `micro_os_plus_startup_post_init_array_hook()`, which turns on the
    `activity_led` (`platform::led_green`); being called after the
    static constructors, the LED object is already initialised;
  - `micro_os_plus_startup_finalise_hardware_hook()`, which turns the
    `activity_led` off, right before the session terminates.
- `src/led-green.cpp` — `platform::led_green` driver for the
  onboard green LED (`PICO_DEFAULT_LED_PIN`), implemented on top of the
  Pico SDK's own `hardware_gpio` driver, unlike the sibling
  raspberry-pi-pico-2-arm platform, which drives the RP2350 CMSIS
  registers directly.

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
Set breakpoint at: `_reset_handler`

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

## Links

- [Pico SDK](https://www.raspberrypi.com/documentation/pico-sdk/)
