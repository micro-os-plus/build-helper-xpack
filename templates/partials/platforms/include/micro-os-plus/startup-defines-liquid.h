// DO NOT EDIT!
// Automatically generated from build-helper/templates/*.
// TODO: generate it via xcdl, and remove this other one from the tests.

// ----------------------------------------------------------------------------

#ifndef MICRO_OS_PLUS_STARTUP_DEFINES_H_
#define MICRO_OS_PLUS_STARTUP_DEFINES_H_

// ----------------------------------------------------------------------------

// The portable startup C++ code for µOS++ applications.
#if !defined(MICRO_OS_PLUS_STARTUP_ENABLED)
#define MICRO_OS_PLUS_STARTUP_ENABLED
#endif // !defined(MICRO_OS_PLUS_STARTUP_ENABLED)

// Add guard checks for data & bss.
// #if !defined(MICRO_OS_PLUS_STARTUP_GUARD_CHECKS_ENABLED)
// #define MICRO_OS_PLUS_STARTUP_GUARD_CHECKS_ENABLED
// #endif // !defined(MICRO_OS_PLUS_STARTUP_GUARD_CHECKS_ENABLED)

// Iterate over the array of multiple RAM sections, if supported by the
// architecture. #if
// !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_MULTIPLE_RAM_SECTIONS_ENABLED)
// #define MICRO_OS_PLUS_STARTUP_INITIALISE_MULTIPLE_RAM_SECTIONS_ENABLED
// #endif // !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_MULTIPLE_RAM_SECTIONS_ENABLED)

// Initialise hardware early.
// #if !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_EARLY_ENABLED)
// #define MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_EARLY_ENABLED
// #endif // !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_EARLY_ENABLED)

// Call the custom hardware initialization.
// #if !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_ENABLED)
// #define MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_ENABLED
// #endif // !defined(MICRO_OS_PLUS_STARTUP_INITIALISE_HARDWARE_ENABLED)

// The exit() and abort() functions used to terminate the application in a
// civilised way, especially when using semihosting.
#if !defined(MICRO_OS_PLUS_STARTUP_EXIT_ENABLED)
#define MICRO_OS_PLUS_STARTUP_EXIT_ENABLED
#endif // !defined(MICRO_OS_PLUS_STARTUP_EXIT_ENABLED)

// The low level heap allocator, in sync with the startup and the linker
// scripts.
#if !defined(MICRO_OS_PLUS_STARTUP_SBRK_ENABLED)
#define MICRO_OS_PLUS_STARTUP_SBRK_ENABLED
#endif // !defined(MICRO_OS_PLUS_STARTUP_SBRK_ENABLED)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_STARTUP_DEFINES_H_

// ----------------------------------------------------------------------------
