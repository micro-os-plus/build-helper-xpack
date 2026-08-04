/*
 * DO NOT EDIT! Automatically generated from template file:
 * {{fromFilePath}}
 *
 * This file is part of the µOS++ project (https://micro-os-plus.github.io/).
 * Copyright (c) 2024-2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

// ----------------------------------------------------------------------------

import { existsSync, readFileSync } from 'fs'
import path from 'path'
import { pathToFileURL } from 'url'
import json5 from 'json5'

// ----------------------------------------------------------------------------

// Note: `process.argv[1]` is not resolved through symlinks (unlike
// `fileURLToPath(import.meta.url)`), matching bash `$0` behaviour. See the
// equivalent comment in `generate-website-commons.mjs`.
const scriptPath = path.resolve(process.argv[1])
const scriptName = path.basename(scriptPath)
const scriptFolderPath = path.dirname(scriptPath)

const projectFolderPath = path.dirname(scriptFolderPath)
const npmHelperMaintenanceScriptsPath = path.join(
  projectFolderPath,
  'node_modules',
  '@xpack',
  'npm-packages-helper',
  'maintenance-scripts',
)

const { substitute } = await import(
  pathToFileURL(path.join(npmHelperMaintenanceScriptsPath, 'scripts-helper.mjs')).href
)

// ----------------------------------------------------------------------------

const argv = process.argv.slice(2)

if (argv.length < 1) {
  console.log(`Usage: ${scriptName} <xcdl-package.jsonc> [<xcdl-package.jsonc>...]`)
  process.exit(1)
}

// ----------------------------------------------------------------------------

const substituteFile = (xcdlJsoncPath) => {
  const outputFolderPath = path.dirname(xcdlJsoncPath)

  console.log()
  console.log(`Processing ${xcdlJsoncPath}...`)

  if (!existsSync(xcdlJsoncPath)) {
    console.log(`missing mandatory ${xcdlJsoncPath}...`)
    process.exit(1)
  }

  // Read in xcdl-package.jsonc and convert to plain JSON.
  const xcdlJson = json5.parse(readFileSync(xcdlJsoncPath, 'utf8'))

  const context = {
    jsonFilePath: xcdlJsoncPath,
    outputFolderPath,
    xcdl: xcdlJson,
  }

  console.log()
  console.log(`"xcdl_context": ${JSON.stringify(context, undefined, 2)}`)

  console.log()
  console.log('generating files...')
  console.log()

  substitute({
    context,
    fromAbsoluteFolderPath: path.join(scriptFolderPath, 'templates'),
    fromRelativeFilePath: 'CMakeLists-liquid.txt',
    toAbsoluteFilePath: path.resolve(outputFolderPath, 'CMakeLists.txt'),
    toRelativeFilePath: path.join(outputFolderPath, 'CMakeLists.txt'),
    substitutionPrefix: '',
  })

  substitute({
    context,
    fromAbsoluteFolderPath: path.join(scriptFolderPath, 'templates'),
    fromRelativeFilePath: 'meson-liquid.build',
    toAbsoluteFilePath: path.resolve(outputFolderPath, 'meson.build'),
    toRelativeFilePath: path.join(outputFolderPath, 'meson.build'),
    substitutionPrefix: '',
  })
}

for (const arg of argv) {
  substituteFile(arg)
}

console.log()
console.log(`'${scriptName} ${argv.join(' ')}' done`)

// ----------------------------------------------------------------------------
