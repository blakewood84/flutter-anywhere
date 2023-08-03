import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required ICharacterRepository characterRepository,
  })  : _repository = characterRepository,
        super(const HomeState()) {
    _initialize();
  }

  final ICharacterRepository _repository;

  void _initialize() async {
    final response = await _repository.fetchCharacters();
    response.fold(
      (characters) => emit(
        state.copyWith(
          characters: characters,
        ),
      ),
      (error) => emit(
        state.copyWith(
          error: error,
        ),
      ),
    );
  }
}
