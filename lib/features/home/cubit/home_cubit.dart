import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:easy_debounce/easy_debounce.dart';
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
          characters: [],
          error: error,
        ),
      ),
    );
  }

  void toggleSearch() {
    emit(
      state.copyWith(
        searchEnabled: !state.searchEnabled,
      ),
    );
  }

  void searchCharacters(String query) async {
    emit(
      state.copyWith(error: null),
    );

    EasyDebounce.debounce(
      'search',
      const Duration(milliseconds: 300),
      () async {
        final response = await _repository.search(query);
        response.fold(
          (characters) => emit(
            state.copyWith(
              characters: characters,
            ),
          ),
          (error) {
            emit(
              state.copyWith(
                error: error,
              ),
            );
          },
        );
      },
    );
  }

  void clearSearch() => emit(
        state.copyWith(
          characters: _repository.originalList,
        ),
      );

  void selectCharacter(Character? character) => emit(
        state.copyWith(selectedCharacter: character),
      );
}
