import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart' show Character;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_cubit.freezed.dart';
part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({
    required this.character,
  }) : super(const DetailsState.initial());

  final Character character;
}
