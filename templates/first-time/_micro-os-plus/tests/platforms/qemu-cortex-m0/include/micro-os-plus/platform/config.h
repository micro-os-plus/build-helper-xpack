/*
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2022-2025 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/mit.
 */

#ifndef MICRO_OS_PLUS_PLATFORM_CONFIG_H_
#define MICRO_OS_PLUS_PLATFORM_CONFIG_H_

// ----------------------------------------------------------------------------

// On bare-metal platforms, tests are semihosted applications.
#define MICRO_OS_PLUS_USE_SEMIHOSTING

#define MICRO_OS_PLUS_INCLUDE_SEMIHOSTING_SYSCALLS
#define MICRO_OS_PLUS_INCLUDE_SEMIHOSTING_STARTUP

#define MICRO_OS_PLUS_INCLUDE_STARTUP
#define MICRO_OS_PLUS_INCLUDE_SBRK
#define MICRO_OS_PLUS_INCLUDE_EXIT

#if defined(MICRO_OS_PLUS_TRACE)
// #define MICRO_OS_PLUS_USE_TRACE_SEMIHOSTING_DEBUG
#define MICRO_OS_PLUS_USE_TRACE_SEMIHOSTING_STDOUT
// #define MICRO_OS_PLUS_USE_TRACE_SEMIHOSTING_STDERR
#endif // MICRO_OS_PLUS_TRACE

// ----------------------------------------------------------------------------

#endif /* MICRO_OS_PLUS_PLATFORM_CONFIG_H_ */

// ----------------------------------------------------------------------------
