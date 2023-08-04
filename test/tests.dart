import 'dart:convert';

import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:character_repository/character_repository.dart';
import 'package:dio/dio.dart' show Dio, BaseOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' show DioAdapter, FullHttpRequestMatcher;

void main() async {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ICharacterRepository characterRepository;

  const args = [
    '?q=simpsons+characters&format=json',
    'Test',
  ];

  final query = args.first;
  final title = args.last;
  const apiUrl = 'https://api.duckduckgo.com';

  group('Bloc & Repository Tests', () {
    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
      dio.httpClientAdapter = dioAdapter;
      characterRepository = CharacterRepository(
        query: query,
        title: title,
        dio: dio,
        apiUrl: apiUrl,
      );
    });

    test('Repository Test - fetchCharacters request', () async {
      final route = '$apiUrl/$query';
      dioAdapter.onGet(route, (server) {
        return server.reply(
          200,
          mockApiResponse,
          delay: const Duration(
            milliseconds: 500,
          ),
        );
      });
      final response = await characterRepository.fetchCharacters();
      final value = response.fold((l) => l, (r) => r);
      expect(value, isInstanceOf<List<Character>>());
    });

    blocTest<HomeCubit, HomeState>(
      'Initialize cubit and fetch characters',
      setUp: () {
        final route = '$apiUrl/$query';
        dioAdapter.onGet(route, (server) {
          return server.reply(
            200,
            mockApiResponse,
            delay: const Duration(
              milliseconds: 300,
            ),
          );
        });
      },
      build: () => HomeCubit(characterRepository: characterRepository),
      wait: const Duration(milliseconds: 400),
      expect: () {
        return [
          HomeState(
            characters: mockCharactersList,
            selectedCharacter: null,
            error: null,
          ),
        ];
      },
    );

    blocTest<HomeCubit, HomeState>(
      'Throw API Error',
      setUp: () {
        dioAdapter.onGet('', (server) {
          return server.reply(
            200,
            mockApiResponse,
            delay: const Duration(
              milliseconds: 0,
            ),
          );
        });
      },
      build: () => HomeCubit(characterRepository: characterRepository),
      wait: const Duration(milliseconds: 300),
      expect: () {
        return [
          const HomeState(
            characters: [],
            error: CharacterError.fetchCharacters,
          ),
        ];
      },
    );

    blocTest<HomeCubit, HomeState>(
      'Search Character Barney',
      setUp: () {
        final route = '$apiUrl/$query';
        dioAdapter.onGet(route, (server) {
          return server.reply(
            200,
            mockApiResponse,
            delay: const Duration(
              milliseconds: 0,
            ),
          );
        });
      },
      build: () => HomeCubit(characterRepository: characterRepository),
      act: (cubit) => cubit.searchCharacters('Barney'),
      wait: const Duration(seconds: 1),
      expect: () {
        return [
          const HomeState(),
          HomeState(
            characters: mockCharactersList,
          ),
          HomeState(
            characters: [
              characterBarney,
            ],
            selectedCharacter: null,
            error: null,
          ),
        ];
      },
    );
  });
}

final mockDataResponse = {
  'RelatedTopics': [
    {
      "FirstURL": "https://duckduckgo.com/Apu_Nahasapeemapetilan",
      "Icon": {"Height": "", "URL": "", "Width": ""},
      "Result":
          "<a href=\"https://duckduckgo.com/Apu_Nahasapeemapetilan\">Apu Nahasapeemapetilan</a><br>Apu Nahasapeemapetilan is a recurring character in the American animated television series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is known for his catchphrase, \"Thank you, come again\".",
      "Text":
          "Apu Nahasapeemapetilan - Apu Nahasapeemapetilan is a recurring character in the American animated television series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is known for his catchphrase, \"Thank you, come again\"."
    },
    {
      "FirstURL": "https://duckduckgo.com/Apu_Nahasapeemapetilon",
      "Icon": {"Height": "", "URL": "/i/99b04638.png", "Width": ""},
      "Result":
          "<a href=\"https://duckduckgo.com/Apu_Nahasapeemapetilon\">Apu Nahasapeemapetilon</a><br>Apu Nahasapeemapetilon is a recurring character in the American animated television series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is known for his catchphrase, \"Thank you, come again\".",
      "Text":
          "Apu Nahasapeemapetilon - Apu Nahasapeemapetilon is a recurring character in the American animated television series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is known for his catchphrase, \"Thank you, come again\"."
    },
    {
      "FirstURL": "https://duckduckgo.com/Barney_Gumble",
      "Icon": {"Height": "", "URL": "/i/39ce98c0.png", "Width": ""},
      "Result":
          "<a href=\"https://duckduckgo.com/Barney_Gumble\">Barney Gumble</a><br>Barnard Arnold \"Barney\" Gumble is a recurring character in the American animated TV series The Simpsons. He is voiced by Dan Castellaneta and first appeared in the series premiere episode \"Simpsons Roasting on an Open Fire\". Barney is the town drunk of Springfield and one of Homer Simpson's friends.",
      "Text":
          "Barney Gumble - Barnard Arnold \"Barney\" Gumble is a recurring character in the American animated TV series The Simpsons. He is voiced by Dan Castellaneta and first appeared in the series premiere episode \"Simpsons Roasting on an Open Fire\". Barney is the town drunk of Springfield and one of Homer Simpson's friends."
    }
  ]
};

final characterBarney = Character.fromJson({
  "FirstURL": "https://duckduckgo.com/Barney_Gumble",
  "Icon": {"Height": "", "URL": "/i/39ce98c0.png", "Width": ""},
  "Result":
      "<a href=\"https://duckduckgo.com/Barney_Gumble\">Barney Gumble</a><br>Barnard Arnold \"Barney\" Gumble is a recurring character in the American animated TV series The Simpsons. He is voiced by Dan Castellaneta and first appeared in the series premiere episode \"Simpsons Roasting on an Open Fire\". Barney is the town drunk of Springfield and one of Homer Simpson's friends.",
  "Text":
      "Barney Gumble - Barnard Arnold \"Barney\" Gumble is a recurring character in the American animated TV series The Simpsons. He is voiced by Dan Castellaneta and first appeared in the series premiere episode \"Simpsons Roasting on an Open Fire\". Barney is the town drunk of Springfield and one of Homer Simpson's friends."
});

final mockCharactersList = [
  for (final character in mockDataResponse['RelatedTopics'] as List<dynamic>) Character.fromJson(character)
];

final mockApiResponse = jsonEncode(mockDataResponse);
