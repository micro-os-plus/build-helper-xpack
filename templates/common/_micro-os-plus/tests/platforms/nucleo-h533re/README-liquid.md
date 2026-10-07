# platforms/nucleo-h533re

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Note: It cannot be a static library, since it makes extensive use of `weak` symbols.

## Source files

This platform does not use STM32CubeMX, the STM32H5xx HAL, or the
STM32H5xx Nucleo BSP for hardware bring-up (unlike the sibling
nucleo-h533re-cubemx platform); everything is implemented directly on
the CMSIS registers, driven from `src/hooks.cpp`:

- `micro_os_plus_startup_initialise_hardware_early_hook()` — called
  from `_start()`, before the data & bss sections are initialised;
  instantiates `device::system_clock` and calls its
  `initialise()` to bring the system clock up to 250 MHz (the
  device's maximum, matching the nucleo-h533re-cubemx platform), from
  the on-board 24 MHz X3 crystal, populated and selected by default on
  this board (see
  `device/include/micro-os-plus/stm32h533re/system-clock.h` for
  details), assigning the result to `SystemCoreClock`.
- `micro_os_plus_startup_initialise_hardware_hook()` — called after the
  data & bss sections are initialised; calls `SystemInit()`
  (`device/src/system-stm32h533xx.cpp`, not the CubeMX-generated one),
  which refreshes `SystemCoreClock` from the still-correctly-configured
  RCC hardware registers via `SystemCoreClockUpdate()` — needed because
  the early hook's own write to `SystemCoreClock` above does not
  survive the `.bss` clear that happens between the two hooks. It does
  not touch the FPU access bits or the vector table offset, both
  already handled earlier, in the architecture-cortexm `Reset_Handler`.
- `micro_os_plus_startup_post_init_array_hook`/
  `micro_os_plus_startup_finalise_hardware_hook` — instantiate
  `activity_led` (`platform::led_green`,
  `src/led-green.cpp`, implemented directly on `RCC`/`GPIOA`, unlike the
  BSP-based nucleo-h533re-cubemx one), turning it on/off around the
  application's run. `led_green` has no data members and a trivial
  default constructor, so there is no actual ordering hazard;
  `post_init_array_hook` is used simply as the conventional point, once
  the C++ runtime is fully up, to touch peripherals.

## OpenOCD invocation

To run the tests, invoke them via OpenOCD:

```sh
openocd \
      -c "gdb port disabled" \
      -c "tcl port disabled" \
      -c "telnet port disabled" \
      -f interface/stlink-dap.cfg \
      -c "adapter speed 5000" \
      -f target/stm32h5x.cfg \
      -c "program test.elf verify" \
      -c "arm semihosting enable" \
      -c "arm semihosting_cmdline test one two" \
      -c "reset"
```
