import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/key.dart';

part 'event.dart';
part 'state.dart';

final class KeysBloc extends Bloc<KeysEvent, KeysState> {
  KeysBloc() : super(const KeysLoadInProgress()) {
    on<KeysInitializeEvent>(_onKeysInitializeEvent, transformer: droppable());
    on<KeysAddEvent>(_onKeysAddEvent, transformer: droppable());
  }

  void _onKeysInitializeEvent(
    KeysInitializeEvent event,
    Emitter<KeysState> emit,
  ) => emit(const KeysLoadOnSuccess([]));

  void _onKeysAddEvent(KeysAddEvent event, Emitter<KeysState> emit) {
    if (state case KeysLoadOnSuccess(:final keys)) {
      emit(KeysLoadOnSuccess([...keys, event.key]..sortBy((e) => e.birthday)));
    }
  }
}
