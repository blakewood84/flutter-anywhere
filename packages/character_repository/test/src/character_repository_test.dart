// ignore_for_file: prefer_const_constructors

import 'package:character_repository/character_repository.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final ICharacterRepository characterRepository = CharacterRepository(
    query: '/?q=simpsons+characters&format=json',
    title: 'Mock',
    apiUrl: 'http://api.duckduckgo.com',
    dio: MockDio(),
  );

  group('CharacterRepository', () {
    test('can be instantiated', () {
      expect(
        characterRepository,
        isNotNull,
      );
    });
  });
}
