import 'package:file/file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:material_ui/material_ui.dart';

part 'types.dart';

@visibleForTesting
base mixin TestValueCubit<T> implements ValueCubit<T> {}

final class ValueCubit<T> extends Cubit<T> {
  ValueCubit(super.initialState);

  void update(T newState) => emit(newState);
}
