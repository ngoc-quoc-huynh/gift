import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/language.dart';

part 'types.dart';

@visibleForTesting
base mixin TestValueCubit<T> implements ValueCubit<T> {}

final class ValueCubit<T> extends Cubit<T> {
  ValueCubit(super.initialState);

  void update(T newState) => emit(newState);
}
