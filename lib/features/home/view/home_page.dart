import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart' show HomeCubit, HomeState;
import 'package:anywhere_mobile/features/home/view/home_view.dart' show HomeView;
import 'package:character_repository/character_repository.dart' show ICharacterRepository;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener, BlocProvider, MultiBlocListener, ReadContext;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        characterRepository: context.read<ICharacterRepository>(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) => current.error != null,
            listener: (context, state) {
              // TODO: Throw Error Dialog
            },
          )
        ],
        child: const HomeView(),
      ),
    );
  }
}
