import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/language.dart';

part 'types.dart';

final class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  void update(State newState) => emit(newState);
}
