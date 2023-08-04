import 'package:anywhere_mobile/features/details/view/details_view.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.character,
    required this.isTablet,
    super.key,
  });

  final Character? character;
  final bool isTablet;

  static Route<void> route(Character character) => MaterialPageRoute(
        builder: (_) => DetailsPage(
          character: character,
          isTablet: false,
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (character == null) {
      return const SizedBox.shrink();
    }

    return DetailsView(
      character: character!,
      isTablet: isTablet,
    );
  }
}
