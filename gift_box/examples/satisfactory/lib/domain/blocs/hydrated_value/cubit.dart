import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/domain/models/locale.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'enum/cubit.dart';
part 'enum/types.dart';
part 'types.dart';

base class HydratedValueCubit<T> extends HydratedCubit<T> {
  HydratedValueCubit({
    required T initialState,
    required this.storageKey,
  }) : super(initialState);

  final String storageKey;

  @mustCallSuper
  void update(T newState) => emit(newState);

  @override
  T fromJson(Map<String, dynamic> json) => json[storageKey] as T;

  @override
  Map<String, dynamic>? toJson(T state) => {storageKey: state};
}
