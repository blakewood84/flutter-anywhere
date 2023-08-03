import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.read<ICharacterRepository>().title;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Loading State
        if (state.characters == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hello World! $title'),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TabletView extends StatelessWidget {
  const _TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
