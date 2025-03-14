import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/add_key.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

final class KeysBloc extends Bloc<KeysEvent, KeysState> {
  KeysBloc() : super(const KeysLoadInProgress()) {
    on<KeysInitializeEvent>(_onKeysInitializeEvent, transformer: droppable());
    on<KeysAddEvent>(_onKeysAddEvent, transformer: droppable());
  }
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeysInitializeEvent(
    KeysInitializeEvent event,
    Emitter<KeysState> emit,
  ) async {
    await _localDatabaseApi.initialize();
    final keys = await _localDatabaseApi.loadKeys();
    emit(KeysLoadOnSuccess(keys));
  }

  Future<void> _onKeysAddEvent(
    KeysAddEvent event,
    Emitter<KeysState> emit,
  ) async {
    if (state case KeysLoadOnSuccess(:final keys)) {
      final newKey = await _localDatabaseApi.saveKey(event.key);

      // TODO: Sort
      final insertIndex = keys.lowerBound(newKey, _compareGiftKeys);
      final newKeys = [...keys]..insert(insertIndex, newKey);

      emit(KeysAddOnSuccess(insertIndex, newKeys));
    }
  }

  static int _compareGiftKeys(GiftKey a, GiftKey b) {
    final dateComparison = b.birthday.compareTo(a.birthday);

    return switch (dateComparison) {
      0 => a.name.compareTo(b.name),
      _ => dateComparison,
    };
  }
}
