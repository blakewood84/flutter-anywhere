// ignore_for_file: inference_failure_on_function_invocation
// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer' as devtools;

import 'package:character_repository/src/models/character.dart';
import 'package:character_repository/src/models/error.dart';
import 'package:character_repository/src/models/interface.dart';
import 'package:dartz/dartz.dart' show Either, left, right;
import 'package:dio/dio.dart' show Dio;
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

/// {@template character_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CharacterRepository implements ICharacterRepository {
  /// {@macro character_repository}
  CharacterRepository({
    required String query,
    required String title,
    required Dio dio,
  })  : _query = query,
        _title = title,
        _dio = dio;

  final String _query;
  final String _title;
  final Dio _dio;

  final _characterListController = BehaviorSubject<List<Character>?>.seeded(
    null,
  );

  /// Base API Url
  static const apiUrl = 'http://api.duckduckgo.com';

  /// Base Asset Image Url
  @override
  String get baseUrl => 'https://duckduckgo.com/';

  @override
  String get title => _title;

  @override
  List<Character>? get originalList => _characterListController.value;

  @override
  Future<Either<List<Character>, CharacterError Function()>> //
      fetchCharacters() async {
    try {
      final response = (await _dio.get('$apiUrl/$_query')).data as String;
      final json = (jsonDecode(response)['RelatedTopics'] //
              as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final characters = <Character>[];

      for (final char in json) {
        final character = Character.fromJson(char);
        characters.add(character);
      }

      _characterListController.add(characters);
      return left(characters);
    } on Exception catch (error, stackTrace) {
      devtools.log(
        'Error making fetchCharacters request!',
        error: error,
        stackTrace: stackTrace,
      );
      return right(CharacterError.fetchCharacters);
    }
  }

  @override
  Future<Either<List<Character>, CharacterError Function()>> search(
    String query,
  ) async {
    devtools.log('query: $query');
    devtools.log('query.isEmpty: ${query.isEmpty}');
    if (query.isEmpty) return left(originalList ?? []);
    try {
      final response = originalList
          ?.where(
            (character) =>
                character.title.contains(
                  query,
                ) ||
                character.description.contains(
                  query,
                ),
          )
          .toList();
      return left(response ?? []);
    } on Exception catch (error, stackTrace) {
      devtools.log(
        'Error making search request!',
        error: error,
        stackTrace: stackTrace,
      );
      return right(CharacterError.search);
    }
  }
}
