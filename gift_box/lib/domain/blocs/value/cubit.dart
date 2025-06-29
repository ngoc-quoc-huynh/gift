import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';

part 'locale/cubit.dart';
part 'types.dart';

base class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  @mustCallSuper
  void update(State newState) => emit(newState);
}
