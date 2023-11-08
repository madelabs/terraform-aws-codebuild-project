# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

- Caching support
- Artifact support
- Custom build image support
- Support for non-GitHub sources

## [0.0.5] - 2023-11-07

### Added

- Added the ability to specify a role arn for the codebuild

## [0.0.4] - 2023-10-20

### Added

- Added the ability to specify the credentials used to pull custom images.

## [0.0.3] - 2023-08-09

### Added

- Added the ability to specify extra permissions that will be associated to the embedded IAM role.

## [0.0.2] - 2023-07-27

### Added

- Added support for boundary policy input.
- Added environment variable support.

## [0.0.1] - 2023-07-20

### Added

- Add initial module for non-artifact CodeBuild projects.

---

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Guiding Principles

- Changelogs are for humans, not machines.
- There should be an entry for every single version.
- The same types of changes should be grouped.
- Versions and sections should be linkable.
- The latest version comes first.
- The release date of each version is displayed.
- Mention whether you follow Semantic Versioning.

Types of changes

- **Added** for new features.
- **Changed** for changes in existing functionality.
- **Deprecated** for soon-to-be removed features.
- **Removed** for now removed features.
- **Fixed** for any bug fixes.
- **Security** in case of vulnerabilities.
