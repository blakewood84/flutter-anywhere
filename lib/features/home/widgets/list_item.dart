import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart';
import 'package:character_repository/character_repository.dart' show Character;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

class ListItem extends StatelessWidget {
  const ListItem({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: .5,
      child: InkWell(
        onTap: () => context.read<HomeCubit>().selectCharacter(character),
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
