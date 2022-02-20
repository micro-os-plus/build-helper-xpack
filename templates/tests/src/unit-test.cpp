/*
 * This file is part of the µOS++ distribution.
 *   (https://github.com/micro-os-plus)
 * Copyright (c) 2021 Liviu Ionescu.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

// ----------------------------------------------------------------------------

#if defined(MICRO_OS_PLUS_INCLUDE_CONFIG_H)
#include <micro-os-plus/config.h>
#endif // MICRO_OS_PLUS_INCLUDE_CONFIG_H

#include <micro-os-plus/platform.h>
#include <micro-os-plus/micro-test-plus.h>
#include <micro-os-plus/xxx/yyy.h>

#include <cassert>
#include <cstring>
#include <stdio.h>

// ----------------------------------------------------------------------------

using namespace micro_os_plus;

// ----------------------------------------------------------------------------

#if defined(__clang__)
#pragma clang diagnostic ignored "-Wc++98-compat"
#endif

// ----------------------------------------------------------------------------

void
test_case_xxx_yyy (micro_test_plus::session& t);

// ----------------------------------------------------------------------------

int
main (int argc, char* argv[])
{
  micro_test_plus::session t (argc, argv);

  t.start_suite ("xxx_yyy test");

  t.run_test_case (test_case_xxx_yyy, "Check xxx_yyy");

  return t.result ();
}

// ----------------------------------------------------------------------------

void
test_case_xxx_yyy (micro_test_plus::session& t)
{
  MTP_EXPECT_PASS(t, "pass");
}

// ----------------------------------------------------------------------------
