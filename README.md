# anywhere_mobile

Anywhere Mobile Engineer Candidate Code Exercise!

## Getting Started

To run the project, there are 2 debug scripts available to run if you are using VSCode:

- Simpsons - Debug
- The Wire - Debug

You may also run each flavor by providing the appropriate commands in the terminal when your emulator is running:

`flutter run --flavor simpsons -t lib/main_simpsons.dart`

or

`flutter run --flavor wire -t lib/main_wire.dart`

## Running Tests

There is a test folder available under `./test/unit_test.dart` at the root of the project folder. To run tests simply run the following in the terminal:

`flutter test`

Tests being ran:

- Repository Test - fetchCharacters request
- Bloc Tests - Cubit initialization, Mock Error, Search

## Packages

To separate the business logic, this project includes one package:

`./packages/character_repository`.

## Open Source Credits

- [Very Good CLI](https://pub.dev/packages/very_good_cli): for dart package creation
- [Flutter Flavorizr](https://pub.dev/packages/flutter_flavorizr) - for quick scaffolding of flavors
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - for state management
- [freezed](https://pub.dev/packages/freezed) - for model scaffolding
- [dartz](https://pub.dev/packages/dartz) - for class union responses
- [dio](https://pub.dev/packages/dio) - for easy network requests
- [easy_debounce](https://pub.dev/packages/easy_debounce) - for method debouncing (search functionality)
- [fast_cached_network_image](https://pub.dev/packages/fast_cached_network_image) - caching images locally on phone
- [shimmer](https://pub.dev/packages/shimmer) - image loading skeleton
- [rxdart](https://pub.dev/packages/rxdart) - stream controllers for storing state in repository
- [Equatable](https://pub.dev/packages/equatable) - Simple equality comparison for character class.

## Preview

<p align="center">
    <img src="./recording.gif" alt="Preview Image" />
</p>
