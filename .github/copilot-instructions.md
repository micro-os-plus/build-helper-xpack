# Copilot Instructions

## Project Overview

This is the **µOS++ build helper** project, part of
µOS++.

## General

- Avoid sycophantic behaviour; for all conversation, never soften criticism
  to protect the person's ego.
- If something has a flaw, say so directly.
- When you're uncertain, say so rather than presenting guesses as facts.
- This applies to every response.

## Language and Tone

- Use British English spelling and grammar (e.g., "behaviour", "colour",
  "organise", "analyse", "favour", "initialise", etc.)
- Maintain a professional and formal tone in all generated content
- Avoid colloquialisms, slang, or informal expressions
- Avoid humour, jokes, or casual remarks
- Use clear, precise, and professional language appropriate for technical
  documentation
- Avoid contractions (e.g., use "do not" instead of "don't")
- Use the Oxford comma in lists for clarity
- Maintain consistency in terminology throughout the codebase
- Prefer "folder" to "directory"
- Use clear, precise, and professional language appropriate for technical
  documentation.

## Code Style

- Follow the existing C++ code style defined in the .clang-format file.
- Use consistent formatting and naming conventions based on prettier and
  clang-format configurations.

## Documentation

- Add comprehensive documentation comments accepted by Doxygen
- Document all classes, methods, properties, parameters, and return types.
- The declarations should be in the headers, the definitions in the `src`
  folder, and the inline definitions in the `inlines` folder.
- Add @details sections to all declarations and definitions.
- The @brief and @details sections are displayed sequentially, so ensure the
  @details section expands on the @brief without repeating it. The @brief
  should be a concise summary of the member's purpose, whilst the @details
  should provide a more in-depth explanation, including any relevant
  information about the implementation, usage, or edge cases.
- Document private and protected members as well
- Keep the line length below 80 characters
- If the code already includes documentation, review and possibly improve it.

## Folder Structure

- `/dev-scripts`: Contains scripts for development tasks, such as build automation, testing, and deployment
- '/doxygen': Contains Doxygen configuration files and related documentation resources
- '/maintenance-scripts': Contains scripts for maintenance tasks, such as template processing
- /templates: Contains template files for code generation, documentation, and other project-related resources

## Code Review

- When asked for a code review, provide constructive feedback on all aspects,
  including the code's readability, maintainability, and adherence to the
  project's coding standards.
- Find every flaw, gap, or weak assumption. Focus on code structure, naming
  conventions, documentation quality, and potential bugs or performance issues.
- Be specific and direct. Do not soften criticism or balance it with positives.
- Mention what you did leave out because you were not certain enough to
  include it.
- Leave the code review result in a separate file named `CODE-REVIEW.md` in
  the root of the project, including a summary of the review findings and
  specific recommendations for improvements.

## Version Control

When making changes to the codebase, follow these guidelines for version control:

- Use descriptive commit messages that clearly explain the purpose of the changes


