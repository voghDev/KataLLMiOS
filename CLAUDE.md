# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KataLLMiOS is an iPhone app that shows a list of LLMs (Large Language Models). The project is managed using Claude Code and GitHub. MIT License (author: Olmo Gallegos).

## Build & Run

```bash
# Build for iOS simulator
xcodebuild -project KataLLMiOS.xcodeproj -scheme KataLLMiOS -sdk iphonesimulator -configuration Debug build

# Run tests (no test target exists yet — add one before running)
xcodebuild -project KataLLMiOS.xcodeproj -scheme KataLLMiOS -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 16' test
```

## Architecture

- **SwiftUI app** using the `App` protocol lifecycle (`@main` in `KataLLMiOSApp.swift`)
- Single target: `KataLLMiOS` (no test targets yet)
- Xcode project uses **FileSystemSynchronizedRootGroup** — source files in `KataLLMiOS/` are auto-synced; no need to manually add files to the Xcode project
- Bundle ID: `es.voghdev.KataLLMiOS`

## Swift & Xcode Configuration

- Swift 5.0 with strict concurrency enabled (`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, `SWIFT_APPROACHABLE_CONCURRENCY = YES`)
- Deployment targets: iOS 26.2, macOS 15.7, visionOS 26.2
- Supported platforms: iPhone, iPad, Mac, visionOS

When performing changes in the code, make sure you always complete these steps before committing any changes:

Obtain a list of available iPhone simulators using:
```
  xcrun simctl list devices available
```

After that, compile the project for Debug and Release configurations and make sure the compilation succeeds:

For Debug configuration (Replace iPhone 17 Pro with the available Simulator you found in previous command. Also replace OS with the valid version):
```
  xcodebuild -project KataLLMiOS.xcodeproj \
      -scheme KataLLMiOS \
      -configuration Debug \
      -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' \
      -destination-timeout 60 \
      build
```

For Release configuration (apply the same transformation in the simulator name and OS):
```
  xcodebuild -project KataLLMiOS.xcodeproj \
      -scheme KataLLMiOS \
      -configuration Release \
      -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' \
      -destination-timeout 60 \
      build
```

After successful compilation, run the tests to ensure nothing is broken (no test target exists yet — add one before running):

```
  xcodebuild -project KataLLMiOS.xcodeproj \
      -scheme KataLLMiOS \
      -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' \
      -destination-timeout 60 \
      test
```

Make sure you never commit any changes to develop branch. If you see that you’re working on develop, switch to a new branch for the requested change.

Avoid unnecessary comments — only comment when the reasoning behind code is non-obvious or critical.

When reading prompts from developers, have in mind that we will compact long class names with only the capital letters. For example LanguagesViewModel will be referred as LVM. When we enter sentences like “Refactor LVM” or “Fix tests in LVMT”, do a search for files that have been recently mentioned and match the capital letters we wrote in the prompt.

We use GitHub for issue management, so we usually name our branches preceded by the issue number. For example, if the issue is 5, we name the branch 5-fix-wrong or fix/5-wrong-margin.
Whenever you find information about the issue number in the branch name or commit messages, please have it in mind for the next prompts. 

In order to obtain information from GitHub issues or any other data from GitHub, you can use GitHub CLI: gh.

When creating PRs, follow the template in `.github/PULL_REQUEST_TEMPLATE.md`.
