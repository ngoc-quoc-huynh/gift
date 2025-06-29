import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'enum/cubit.dart';
part 'enum/types.dart';
part 'types.dart';

base class HydratedValueCubit<State> extends HydratedCubit<State> {
  HydratedValueCubit({
    required State initialState,
    required this.storageKey,
  }) : super(initialState);

  final String storageKey;

  @mustCallSuper
  void update(State newState) => emit(newState);

  @override
  State fromJson(Map<String, dynamic> json) => json[storageKey] as State;

  @override
  Map<String, dynamic>? toJson(State state) => {storageKey: state};
}
