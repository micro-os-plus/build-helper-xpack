# platforms/nucleo-h533re-cubemx

> DO NOT EDIT! Automatically generated from template file:
> {{fromFilePath}}

Note: It cannot be a static library, since it makes extensive use of `weak` symbols.

## Source files

- `src/hooks.cpp` — the `micro_os_plus_startup_initialise_hardware_hook`,
  `micro_os_plus_startup_post_init_array_hook` and
  `micro_os_plus_startup_finalise_hardware_hook` hooks (called from
  `micro_os_plus_startup_run_main()`/`exit()`). `initialise_hardware_hook`
  simply calls the CubeMX-generated `cubemx_main()` (`main()` renamed,
  see `device/README.md`), which brings up the clocks and calls
  `BSP_LED_Init(LED_GREEN)`/`BSP_LED_On(LED_GREEN)`. The other two
  hooks instantiate the `activity_led` (`platform::led_green`),
  turning it on/off around the application's run. `led_green` has no
  data members and a trivial default constructor, so there is no
  actual ordering hazard; `post_init_array_hook` is used simply as the
  conventional point, once the C++ runtime is fully up, to touch
  peripherals. No `initialise_hardware_early_hook` is needed, as
  `initialise_hardware_hook` already brings up the clocks and calls
  `BSP_LED_Init(LED_GREEN)`/`BSP_LED_On(LED_GREEN)` itself; this
  driver only adds turning the LED off again on exit.
- `src/led-green.cpp` — `platform::led_green`
  driver for the onboard green LED (`LED_GREEN`, `LED2`/`PA5` on this
  Nucleo-64 board), implemented on top of the STM32H5xx Nucleo BSP's
  `BSP_LED_*()` calls, already linked in via
  `stm32cubemx-drivers-objects-library` (see `device/CMakeLists.txt`),
  unlike the sibling nucleo-f411re-cubemx/nucleo-f767zi-cubemx
  platforms, whose CubeMX projects have no BSP layer and drive
  `HAL_GPIO_*()` directly.

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
