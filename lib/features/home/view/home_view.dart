import 'package:anywhere_mobile/extensions/media_query.dart';
import 'package:anywhere_mobile/features/details/view/details_page.dart';
import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart' show HomeCubit, HomeState;
import 'package:character_repository/character_repository.dart' show Character, ICharacterRepository;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext, SelectContext;

extension IsTablet on BuildContext {}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.read<ICharacterRepository>().title;
    final isTablet = MediaQuery.of(context).isTablet;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final characters = state.characters;

        // Loading State
        if (characters == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white.withOpacity(.55),
            elevation: 0,
            title: Text(
              '$title Characters',
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
          body: !isTablet
              ? _MobileView(
                  characters: characters,
                )
              : const _TabletView(),
        );
      },
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView({
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters.elementAt(index);
          return _CharacterCard(
            character: character,
          );
        },
      ),
    );
  }
}

class _TabletView extends StatelessWidget {
  const _TabletView();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: .5,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          DetailsPage.route(character),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(character.title),
          ),
        ),
      ),
    );
  }
}
