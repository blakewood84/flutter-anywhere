// ignore_for_file: inference_failure_on_function_invocation, avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer' as devtools;

import 'package:character_repository/src/models/character.dart';
import 'package:character_repository/src/models/error.dart';
import 'package:character_repository/src/models/interface.dart';
import 'package:dartz/dartz.dart' show Either, left, right;
import 'package:dio/dio.dart' show Dio;

/// {@template character_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CharacterRepository implements ICharacterRepository {
  /// {@macro character_repository}
  const CharacterRepository({
    required String query,
    required String title,
  })  : _query = query,
        _title = title;

  final String _query;
  final String _title;

  /// Base API Url
  static const apiUrl = 'http://api.duckduckgo.com';

  /// Base Asset Image Url
  static const baseUrl = 'https://duckduckgo.com/';

  @override
  String get title => _title;

  @override
  Future<Either<List<Character>, CharacterError Function()>> fetchCharacters() async {
    try {
      final response = (await Dio().get('$apiUrl/$_query')).data as String;
      final json = (jsonDecode(response)['RelatedTopics'] //
              as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final characters = <Character>[];

      for (final char in json) {
        final character = Character.fromJson(char);
        characters.add(character);
      }

      devtools.log('characters: $characters');

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
}
