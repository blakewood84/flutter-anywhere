# Character Repository

A Character Repository

[![License: MIT][license_badge]][license_link]

## Installation 💻

**❗ In order to start using Character Repository you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `character_repository` to your `pubspec.yaml`:

```yaml
dependencies:
  character_repository:
```

Install it:

```sh
dart pub get
```

---

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[dart_install_link]: https://dart.dev/get-dart
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
