import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/language.dart';

part 'types.dart';

@visibleForTesting
base mixin TestValueCubit<State> implements ValueCubit<State> {}

final class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  void update(State newState) => emit(newState);
}
