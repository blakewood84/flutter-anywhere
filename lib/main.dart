import 'dart:async' show FutureOr;

import 'package:character_repository/character_repository.dart' show CharacterRepository, Dio, ICharacterRepository;
import 'package:fast_cached_network_image/fast_cached_network_image.dart' show FastCachedImageConfig;
import 'package:flutter/material.dart' show runApp;

import 'app.dart' show App;

FutureOr<void> main(List<String> args) async {
  final query = args.first;
  final title = args.last;

  final dio = Dio();

  final ICharacterRepository characterRepository = CharacterRepository(
    query: query,
    title: title,
    dio: dio,
    apiUrl: 'https://api.duckduckgo.com',
  );

  await FastCachedImageConfig.init(
    clearCacheAfter: const Duration(days: 1),
  );

  runApp(
    App(
      characterRepository: characterRepository,
    ),
  );
}
