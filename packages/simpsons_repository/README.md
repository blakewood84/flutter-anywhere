# Simpsons Repository

[![License: MIT][license_badge]][license_link]

## Installation 💻

**❗ In order to start using Simpsons Repository you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `simpsons_repository` to your `pubspec.yaml`:

```yaml
dependencies:
  simpsons_repository:
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
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
