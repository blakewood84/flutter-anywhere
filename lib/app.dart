import 'package:character_repository/character_repository.dart' show ICharacterRepository;
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    required ICharacterRepository characterRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
