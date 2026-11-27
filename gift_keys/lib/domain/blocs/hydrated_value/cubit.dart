import 'package:gift_keys/domain/models/language.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:material_ui/material_ui.dart';

part 'language_option.dart';
part 'theme_mode.dart';

sealed class HydratedValueCubit<T> extends HydratedCubit<T> {
  HydratedValueCubit(super.state);

  void update(T newState) => emit(newState);
}
