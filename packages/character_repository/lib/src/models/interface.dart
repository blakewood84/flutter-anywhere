import 'package:character_repository/src/models/character.dart';
import 'package:character_repository/src/models/error.dart';
import 'package:dartz/dartz.dart';

/// Interface for CharacterRepository
abstract interface class ICharacterRepository {
  ///
  const ICharacterRepository();

  /// Fetch a list of characters
  Future<Either<List<Character>, CharacterError Function()>> fetchCharacters();

  /// Title of the type of characters being fetched.
  String get title;
}
