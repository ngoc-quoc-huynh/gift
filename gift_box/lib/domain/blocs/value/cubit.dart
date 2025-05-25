import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'types.dart';

final class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  void update(State newState) => emit(newState);
}
