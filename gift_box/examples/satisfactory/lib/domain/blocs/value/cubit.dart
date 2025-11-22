import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/models/locale.dart';
import 'package:gift_box_satisfactory/injector.dart';

part 'bool/welcome_overlay.dart';
part 'locale/cubit.dart';
part 'types.dart';

base class ValueCubit<T> extends Cubit<T> {
  ValueCubit(super.initialState);

  @mustCallSuper
  void update(T newState) => emit(newState);
}
