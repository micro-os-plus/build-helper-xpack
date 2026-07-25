// DO NOT EDIT!
// Automatically generated from build-helper/templates/*.
// TODO: generate it via xcdl, and remove this other one from the tests.

// ----------------------------------------------------------------------------

#ifndef MICRO_OS_PLUS_SEMIHOSTING_DEFINES_H_
#define MICRO_OS_PLUS_SEMIHOSTING_DEFINES_H_

// ----------------------------------------------------------------------------

// Define the Arm semihosting call numbers and API.
#if !defined(MICRO_OS_PLUS_SEMIHOSTING_ENABLED)
#define MICRO_OS_PLUS_SEMIHOSTING_ENABLED
#endif // !defined(MICRO_OS_PLUS_SEMIHOSTING_ENABLED)

// Implement all POSIX functions over the Arm semihosting API; it complements
// the newlib implementation and adds debugging support.
#if !defined(MICRO_OS_PLUS_SEMIHOSTING_SYSCALLS_ENABLED)
#define MICRO_OS_PLUS_SEMIHOSTING_SYSCALLS_ENABLED
#endif // !defined(MICRO_OS_PLUS_SEMIHOSTING_SYSCALLS_ENABLED)

// Get the command line arguments via SYS_GETCMDLINE and parse them as for
// main(arc, argv); pass the return code back to the debugger when the
// application terminates.
#if !defined(MICRO_OS_PLUS_SEMIHOSTING_STARTUP_ENABLED)
#define MICRO_OS_PLUS_SEMIHOSTING_STARTUP_ENABLED
#endif // !defined(MICRO_OS_PLUS_SEMIHOSTING_STARTUP_ENABLED)

// Enable debugging for the semihosting trace channel faults.
// #if !defined(MICRO_OS_PLUS_SEMIHOSTING_DEBUG_FAULTS_ENABLED)
// #define MICRO_OS_PLUS_SEMIHOSTING_DEBUG_FAULTS_ENABLED
// #endif // !defined(MICRO_OS_PLUS_SEMIHOSTING_DEBUG_FAULTS_ENABLED)

// ----------------------------------------------------------------------------

#endif // MICRO_OS_PLUS_SEMIHOSTING_DEFINES_H_

// ----------------------------------------------------------------------------
