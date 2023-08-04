import 'dart:async';

import 'package:character_repository/character_repository.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app.dart';

FutureOr<void> main(List<String> args) async {
  final query = args.first;
  final title = args.last;

  final ICharacterRepository characterRepository = CharacterRepository(
    query: query,
    title: title,
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
