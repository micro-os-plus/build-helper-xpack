#!/usr/bin/env node

/*
 * This file is part of the µOS++ project (http://micro-os-plus.github.io).
 * Copyright (c) 2024-2026 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can be
 * obtained from https://opensource.org/licenses/mit.
 */

// ----------------------------------------------------------------------------
// Generates (or refreshes) the tests common files of a micro-os-plus
// project, from the liquid templates in the sibling `templates` folder.
// Invoked via the consuming project's `generate-tests-commons` npm script
// (in `tests/package.json`).

import { existsSync, rmSync } from 'fs'
import path from 'path'
import { pathToFileURL } from 'url'
import { globSync } from 'glob'

// ----------------------------------------------------------------------------

// Note: `process.argv[1]` is not resolved through symlinks (unlike
// `fileURLToPath(import.meta.url)`), matching bash `$0` behaviour. This
// matters because `@micro-os-plus/build-helper` is typically installed as
// a symlink to a shared checkout, and both the project folder location and
// the sibling `@xpack/npm-packages-helper` package are derived from the
// invocation path, not the real script location. For the same reason, the
// helper is loaded with a dynamic import of a computed absolute path
// rather than a static relative specifier, which Node would resolve
// against the real (symlink-followed) location of this file instead.
const scriptPath = path.resolve(process.argv[1])
const scriptName = path.basename(scriptPath)
const scriptFolderPath = path.dirname(scriptPath)

// Runs as
// .../tests/node_modules/@micro-os-plus/build-helper/maintenance-scripts/generate-tests-commons.mjs
const nodeModulesFolderPath = path.dirname(path.dirname(path.dirname(scriptFolderPath)))
const npmHelperMaintenanceScriptsPath = path.join(
  nodeModulesFolderPath,
  '@xpack',
  'npm-packages-helper',
  'maintenance-scripts',
)

const {
  parseOptions,
  checkIfShouldIgnorePath,
  prepareToPaths,
  computeContext,
  substitute,
  processFile,
} = await import(
  pathToFileURL(path.join(npmHelperMaintenanceScriptsPath, 'scripts-helper.mjs')).href
)

// ----------------------------------------------------------------------------

const templatesFolderPath = path.join(path.dirname(scriptFolderPath), 'templates')
const partialsFolderPath = path.join(templatesFolderPath, 'partials')

// ----------------------------------------------------------------------------

// Removes the destination file corresponding to a template item, replacing
// the `--remove` branch of the bash `process-template-item.sh` script.
const removeTemplateItem = (relativeFilePath, projectFolderPath, options) => {
  if (checkIfShouldIgnorePath(relativeFilePath, options.acceptedPath)) {
    return
  }

  const { fromRelativeFilePath, toRelativeFilePath, toAbsoluteFilePath } = prepareToPaths(
    relativeFilePath,
    projectFolderPath,
  )

  if (path.basename(fromRelativeFilePath) === '.DS_Store') {
    console.log(`${fromRelativeFilePath} ignored`) // Skip macOS specifics.
    return
  }

  if (existsSync(toAbsoluteFilePath)) {
    console.log(`removing: ${toRelativeFilePath}`)
    if (!options.doDryRun) {
      rmSync(toAbsoluteFilePath, { force: true })
    }
  }
}

// Copies, or renders and copies, a single template item to its
// destination, replacing the default branch of the bash
// `process-template-item.sh` script. Unlike the org-level
// `process-top-template-item.sh`, there are currently no destination
// paths to skip for the micro-os-plus tests templates.
const processTemplateItem = (relativeFilePath, projectFolderPath, params) => {
  const { context, options, doForce, fromAbsoluteFolderPath, substitutionPrefix } = params

  if (checkIfShouldIgnorePath(relativeFilePath, options.acceptedPath)) {
    return
  }

  const { fromRelativeFilePath, toRelativeFilePath, toAbsoluteFilePath } = prepareToPaths(
    relativeFilePath,
    projectFolderPath,
  )

  if (path.basename(fromRelativeFilePath) === '.DS_Store') {
    console.log(`${fromRelativeFilePath} ignored`) // Skip macOS specifics.
    return
  }

  // Duplicate, already present in processFile().
  // if (existsSync(toAbsoluteFilePath) && !doForce) {
  //   console.log(`already present: ${toRelativeFilePath}`)
  //   return
  // }

  processFile({
    context,
    fromAbsoluteFolderPath,
    partialsFolderPath,
    fromRelativeFilePath,
    toRelativeFilePath,
    toAbsoluteFilePath,
    substitutionPrefix,
    doForce,
    doDryRun: options.doDryRun,
  })
}

// Returns the platform name segment following a `tests/platforms/` prefix
// in a relative path, or undefined if the path does not contain it.
const platformNameOf = (relativeFilePath) => {
  const marker = 'tests/platforms/'
  const index = relativeFilePath.indexOf(marker)
  if (index === -1) {
    return undefined
  }
  const rest = relativeFilePath.slice(index + marker.length)
  return rest.split('/')[0]
}

// ----------------------------------------------------------------------------

const argv = process.argv.slice(2)

// Parse --init, --dry-run, --micro-os-plus.
const options = parseOptions(argv)

if (!options.isMicroOsPlus) {
  console.log('Unsupported configuration...')
  process.exit(1)
}

// The script is invoked via the following tests npm script:
// "generate-tests-commons": "node node_modules/@micro-os-plus/build-helper/maintenance-scripts/generate-tests-commons.mjs"
const currentFolderPath = path.dirname(
  path.dirname(path.dirname(path.dirname(scriptFolderPath))),
)
const projectFolderPath = path.dirname(currentFolderPath)
const testsFolderPath = path.join(projectFolderPath, 'tests')

let templatesRelativeFolderPath = templatesFolderPath.startsWith(`${projectFolderPath}/`)
  ? templatesFolderPath.slice(projectFolderPath.length + 1)
  : templatesFolderPath
templatesRelativeFolderPath = templatesRelativeFolderPath.replace(
  /^.*?node_modules\/@xpack\//,
  '',
)
templatesRelativeFolderPath = templatesRelativeFolderPath.replace(
  /^.*?node_modules\/@micro-os-plus\//,
  '',
)

// ----------------------------------------------------------------------------

// Process package.json files and leave results in the context object.
const context = computeContext({ projectFolderPath, testsFolderPath, options })

// ----------------------------------------------------------------------------

if (options.doDryRun) {
  console.log()
  console.log('Dry run!')
}

// ----------------------------------------------------------------------------

if (options.doInit) {
  substitute({
    context,
    fromAbsoluteFolderPath: path.join(templatesFolderPath, 'common', '_micro-os-plus', 'tests'),
    partialsFolderPath,
    fromRelativeFilePath: 'package-merge-liquid.json',
    toAbsoluteFilePath: path.join(testsFolderPath, 'package.json'),
    substitutionPrefix: '',
    doDryRun: options.doDryRun,
  })
} else {
  console.log()
  console.log(`Processing template from ${templatesFolderPath}...`)

  const commonFolderPath = path.join(templatesFolderPath, 'common')
  const commonSubstitutionPrefix = `${templatesRelativeFolderPath}/common`

  const platforms = context.testsConfig.platforms

  const commonFiles = globSync('**/*', { cwd: commonFolderPath, dot: true, nodir: true }).sort()

  for (const relativeFilePath of commonFiles) {
    const item = `./${relativeFilePath}`
    if (!item.includes('tests/platforms')) {
      processTemplateItem(item, projectFolderPath, {
        context,
        options,
        doForce: true,
        fromAbsoluteFolderPath: commonFolderPath,
        substitutionPrefix: commonSubstitutionPrefix,
      })
    } else if (platforms.includes(platformNameOf(item))) {
      processTemplateItem(item, projectFolderPath, {
        context,
        options,
        doForce: true,
        fromAbsoluteFolderPath: commonFolderPath,
        substitutionPrefix: commonSubstitutionPrefix,
      })
    } else {
      removeTemplateItem(item, projectFolderPath, options)
    }
  }

  console.log()
  console.log('First time proposals...')

  const firstTimeFolderPath = path.join(templatesFolderPath, 'first-time')
  const firstTimeSubstitutionPrefix = `${templatesRelativeFolderPath}/first-time`

  const firstTimeFiles = globSync('**/*', {
    cwd: firstTimeFolderPath,
    dot: true,
    nodir: true,
  }).sort()

  for (const relativeFilePath of firstTimeFiles) {
    const item = `./${relativeFilePath}`
    if (!item.includes('tests/platforms') || platforms.includes(platformNameOf(item))) {
      processTemplateItem(item, projectFolderPath, {
        context,
        options,
        doForce: false,
        fromAbsoluteFolderPath: firstTimeFolderPath,
        substitutionPrefix: firstTimeSubstitutionPrefix,
      })
    }
  }
}

// ----------------------------------------------------------------------------

console.log()
console.log(`'${scriptName} ${argv.join(' ')}' done`)
