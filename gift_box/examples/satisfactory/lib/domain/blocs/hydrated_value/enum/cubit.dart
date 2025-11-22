part of '../cubit.dart';

final class HydratedEnumCubit<T extends Enum> extends HydratedValueCubit<T> {
  HydratedEnumCubit({
    required super.initialState,
    required super.storageKey,
    required this.values,
  });

  final List<T> values;

  @override
  T fromJson(Map<String, dynamic> json) =>
      values.byName(json[storageKey] as String);

  @override
  Map<String, dynamic>? toJson(T state) => {storageKey: state.name};
}
