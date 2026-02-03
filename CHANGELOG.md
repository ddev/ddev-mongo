# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## SemVer public API

The [public API](https://semver.org/spec/v2.0.0.html#spec-item-1) of this project is determined by the `install.
yaml` file, along with all files specified under `project_files` within `install.yaml`.

---

## [v2.3.1](https://github.com/ddev/ddev-mongo/releases/tag/v2.3.1) - 2026-02-03
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v2.3.0...v2.3.1)

### Changed

- Use `MONGO_INITDB_DATABASE=db` to create a default database.

## [v2.3.0](https://github.com/ddev/ddev-mongo/releases/tag/v2.3.0) - 2026-01-28
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v2.2.1...v2.3.0)

### Changed

- Add mongo cli tools to the `ddev-webserver`, use `mongo:latest`
- Minimum required DDEV version is 1.24.10.

---

## [v2.2.1](https://github.com/ddev/ddev-mongo/releases/tag/v2.2.1) - 2025-09-15
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v2.2.0...v2.2.1)

### Changed

- Add `config.mongo.yaml` to the add-on files.

---

## [v2.2.0](https://github.com/ddev/ddev-mongo/releases/tag/v2.2.0) - 2025-04-18
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v2.1.0...v2.2.0)

### Changed

- Mongo Express can be started on demand using the `ddev mongo-express` command.
- Minimum required DDEV version is 1.24.4.

---

## [v2.1.0](https://github.com/ddev/ddev-mongo/releases/tag/v2.1.0) - 2024-10-31
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v2.0.0...v2.1.0)

### Added

- Add `mongo-express` command to open the Mongo Express UI in the browser
- Add `docker-compose.mongo_norouter.yaml` to handle the omitted `ddev-router` container case


---

## [v2.0.0](https://github.com/ddev/ddev-mongo/releases/tag/v2.0.0) - 2024-03-29
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v1.2.0...v2.0.0)

### Changed

- **Breaking change**: Use `ExecRaw: true` annotation for the `mongosh` command (pass command arguments directly to the container as-is)


---

## [v1.2.0](https://github.com/ddev/ddev-mongo/releases/tag/v1.2.0) - 2024-03-28
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v1.1.0...v1.2.0)

### Changed

- Update `mongo-express` to `1.0`
- Update `mongo-express` configuration variables

### Added

- Add `HTTPS_EXPOSE` for `mongo-express` container

---

## [v1.1.0](https://github.com/ddev/ddev-mongo/releases/tag/v1.1.0) - 2023-11-30
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v1.0.1...v1.1.0)

### Added

- Add explicit `mongo-config` volume for `/data/configdb` ([PR #17](https://github.com/ddev/ddev-mongo/pull/17))

---


## [v1.0.1](https://github.com/ddev/ddev-mongo/releases/tag/v1.0.1) - 2023-08-20
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v1.0.0...v1.0.1)

### Fixed

- Wait 5 seconds before starting `mongo-express` to avoid random failures ([@see #14](https://github.com/ddev/ddev-mongo/issues/14))

---


## [v1.0.0](https://github.com/ddev/ddev-mongo/releases/tag/v1.0.0) - 2023-08-08
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.1.4...v1.0.0)

### Added

- Add `ddev mongosh` command

---


## [v0.1.4](https://github.com/ddev/ddev-mongo/releases/tag/v0.1.4) - 2023-02-04
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.1.3...v0.1.4)

### Changed

- Move to ddev domain

---

## [v0.1.3](https://github.com/ddev/ddev-mongo/releases/tag/v0.1.3) - 2022-12-10
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.1.2...v0.1.3)

### Fixed

- Add ddev-description in `install.yaml`

---

## [v0.1.2](https://github.com/ddev/ddev-mongo/releases/tag/v0.1.2) - 2022-06-22
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.1.1...v0.1.2)

### Fixed

- Make test failures more readable

---


## [v0.1.1](https://github.com/ddev/ddev-mongo/releases/tag/v0.1.1) - 2022-06-22
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.1.0...v0.1.1)

### Fixed

- Add missing ddev-generated comment

---


## [v0.1.0](https://github.com/ddev/ddev-mongo/releases/tag/v0.1.0) - 2022-04-05
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.0.3...v0.1.0)

### Changed

- Increase healthcheck timeout to 60s

---


## [v0.0.3](https://github.com/ddev/ddev-mongo/releases/tag/v0.0.3) - 2022-03-30
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.0.2...v0.0.3)

### Changed

- Make mongo-express dependent on mongo
- Change host-side port to 9091 for fewer conflicts

### Fixed

- Fix healthcheck

---

## [v0.0.2](https://github.com/ddev/ddev-mongo/releases/tag/v0.0.2) - 2022-03-29
[_Compare with previous release_](https://github.com/ddev/ddev-mongo/compare/v0.0.1...v0.0.2)

### Added

- Add healthcheck

---

## [0.0.1](https://github.com/ddev/ddev-mongo/releases/tag/v0.0.1) - 2022-03-29

### Added
- Initial release
