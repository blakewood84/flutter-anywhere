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
    required String apiUrl,
    required Dio dio,
  })  : _query = query,
        _title = title,
        _apiUrl = apiUrl,
        _dio = dio;

  final String _apiUrl;
  final String _query;
  final String _title;
  final Dio _dio;

  @override
  String get baseUrl => 'https://duckduckgo.com/';

  @override
  String get title => _title;

  @override
  String get apiUrl => _apiUrl;

  @override
  List<Character>? get originalList => _characterListController.value;

  /// Keeps track of the original API data
  final _characterListController = BehaviorSubject<List<Character>?>.seeded(
    null,
  );

  @override
  Future<Either<List<Character>, CharacterError Function()>> //
      fetchCharacters() async {
    try {
      final response = (await _dio.get('$_apiUrl/$_query')).data as String;

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
    if (query.isEmpty) return left(originalList ?? []);
    try {
      final response = originalList
          ?.where(
            (character) =>
                character.title.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                character.description.toLowerCase().contains(
                      query.toLowerCase(),
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
