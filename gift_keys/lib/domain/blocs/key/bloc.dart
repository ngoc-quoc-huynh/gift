import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

final class KeyBloc extends Bloc<KeyEvent, KeyState> {
  KeyBloc(this._id) : super(const KeyLoadInProgress()) {
    on<KeyInitializeEvent>(_onKeyInitializeEvent, transformer: droppable());
  }

  final int _id;

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeyInitializeEvent(
    KeyInitializeEvent event,
    Emitter<KeyState> emit,
  ) async {
    emit(const KeyLoadInProgress());

    try {
      final giftKey = await _localDatabaseApi.loadKey(_id);
      emit(KeyLoadOnSuccess(giftKey));
    } on LocalDatabaseException {
      emit(const KeyLoadOnFailure());
    }
  }
}
