import 'package:anywhere_mobile/features/details/cubit/details_cubit.dart';
import 'package:anywhere_mobile/features/details/view/details_view.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.character,
    super.key,
  });

  final Character character;

  static Route<void> route(Character character) => MaterialPageRoute(
        builder: (_) => DetailsPage(
          character: character,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(
        character: character,
      ),
      child: const DetailsView(),
    );
  }
}
