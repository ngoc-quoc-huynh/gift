import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'types.dart';

final class HydratedValueCubit<State> extends HydratedCubit<State> {
  HydratedValueCubit({required State initialState, required this.storageKey})
    : super(initialState);
  final String storageKey;

  void update(State newState) => emit(newState);

  @override
  State fromJson(Map<String, dynamic> json) => json[storageKey] as State;

  @override
  Map<String, dynamic>? toJson(State state) => {storageKey: state};
}
