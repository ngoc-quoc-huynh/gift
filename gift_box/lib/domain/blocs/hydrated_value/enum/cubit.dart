part of '../cubit.dart';

final class HydratedEnumCubit<State extends Enum>
    extends HydratedValueCubit<State> {
  HydratedEnumCubit({
    required super.initialState,
    required super.storageKey,
    required this.values,
  });

  final List<State> values;

  @override
  State fromJson(Map<String, dynamic> json) =>
      values.byName(json[storageKey] as String);

  @override
  Map<String, dynamic>? toJson(State state) => {storageKey: state.name};
}
