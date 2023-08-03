import 'package:anywhere_mobile/features/home/view/home_page.dart' show HomePage;
import 'package:character_repository/character_repository.dart' show ICharacterRepository;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiRepositoryProvider, RepositoryProvider;

class App extends StatelessWidget {
  const App({
    required ICharacterRepository characterRepository,
    super.key,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => _characterRepository,
        ),
      ],
      child: MaterialApp(
        title: _characterRepository.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: const HomePage(),
      ),
    );
  }
}
