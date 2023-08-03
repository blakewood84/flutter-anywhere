part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(null) List<Character>? characters,
    @Default(null) CharacterError Function()? error,
  }) = _HomeState;
}
