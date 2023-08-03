import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

/// Denotes an exception thrown by either service
@freezed
sealed class CharacterError with _$CharacterError {
  @Implements<Exception>()

  /// An Exception thrown fetching characters
  const factory CharacterError.fetchCharacters() = FetchCharacters;

  /// An Exception thrown when searching characters
  const factory CharacterError.search() = Search;
}
