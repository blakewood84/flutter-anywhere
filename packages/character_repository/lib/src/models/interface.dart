import 'package:character_repository/src/models/character.dart';
import 'package:character_repository/src/models/error.dart';
import 'package:dartz/dartz.dart';

/// Interface for CharacterRepository
abstract interface class ICharacterRepository {
  ///
  const ICharacterRepository();

  /// Fetch a list of characters
  Future<Either<List<Character>, CharacterError Function()>> fetchCharacters();

  /// Search Characters
  Future<Either<List<Character>, CharacterError Function()>> search(
    String query,
  );

  /// Supplies the original list of characters fetched from the API
  List<Character>? get originalList;

  /// Title of the type of characters being fetched.
  String get title;

  /// Base URL to use for network images
  String get baseUrl;

  /// API Url
  String get apiUrl;
}
