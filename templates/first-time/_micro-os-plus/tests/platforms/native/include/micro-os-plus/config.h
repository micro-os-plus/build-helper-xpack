/*
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2022-2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

#ifndef MICRO_OS_PLUS_CONFIG_H_
#define MICRO_OS_PLUS_CONFIG_H_

// ----------------------------------------------------------------------------
// Platform configuration definitions.
// Assembly files should define `#define __ASSEMBLY__ 1` before including
// this file. If so, this file should define only preprocessor macros.

#if defined(MICRO_OS_PLUS_TRACE)
#define MICRO_OS_PLUS_USE_TRACE_POSIX_STDOUT
// #define MICRO_OS_PLUS_USE_TRACE_POSIX_STDERR

// #define MICRO_OS_PLUS_TRACE_UTILS_LISTS_CONSTRUCT
// #define MICRO_OS_PLUS_TRACE_UTILS_LISTS

#define MICRO_OS_PLUS_INTEGER_TRACE_PRINTF_BUFFER_ARRAY_SIZE 500

// Propagate TRACE to the library.
#define MICRO_OS_PLUS_TRACE_MICRO_TEST_PLUS
#endif // MICRO_OS_PLUS_TRACE

// ----------------------------------------------------------------------------

#endif /* MICRO_OS_PLUS_CONFIG_H_ */

// ----------------------------------------------------------------------------
