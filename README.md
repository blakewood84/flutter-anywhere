# anywhere_mobile

Anywhere Mobile Engineer Candidate Code Exercise

## Getting Started

To run the project, there are 2 debug scripts available to run if you are using VSCode:

- Simpsons - Debug
- The Wire - Debug

You may also run each flavor by providing the appropriate commands in the terminal when your emulator is running:

`flutter run --flavor simpsons -t lib/main_simpsons.dart`

or

`flutter run --flavor wire -t lib/main_wire.dart`

## Running Tests

There is a test folder available under `./test/tests.dart` at the root of the project folder. To run tests simply run the following in the terminal:

`flutter test`

Tests being ran:

- Repository Test - fetchCharacters request
- Bloc Tests - Cubit initialization, Mock Error, Search

## Packages

To separate the business logic, this project includes one package: `character_repository`.

## Open Source Pub Credits

- Very Good CLI - for dart package creation: [Link](https://pub.dev/packages/very_good_cli)
- Flutter Flavorizr - for quick scaffolding of flavors: [Link](https://pub.dev/packages/flutter_flavorizr)
- Flutter Bloc - for state management: [Link](https://pub.dev/packages/flutter_bloc)
- Freezed - for model scaffolding: [Link](https://pub.dev/packages/freezed)
- dartz - for class union responses: [Link](https://pub.dev/packages/dartz)
- dio - for easy network requests: [Link](https://pub.dev/packages/dio)
-
