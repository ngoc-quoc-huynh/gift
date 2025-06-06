import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

base mixin TestKeyFormBlocMixin implements KeyFormBloc {}

final class KeyFormBloc extends Bloc<KeyFormEvent, KeyFormState> {
  KeyFormBloc() : super(const KeyFormInitial()) {
    on<KeyFormAddEvent>(_onKeyFormAddEvent, transformer: droppable());
    on<KeyFormUpdateEvent>(_onKeyFormUpdateEvent, transformer: droppable());
    on<KeyFormDeleteEvent>(_onKeyFormDeleteEvent, transformer: droppable());
  }

  static final _fileApi = Injector.instance.fileApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeyFormAddEvent(
    KeyFormAddEvent event,
    Emitter<KeyFormState> emit,
  ) async {
    emit(const KeyFormLoadInProgress());

    try {
      final newMeta = await _localDatabaseApi.saveKey(
        name: event.name,
        birthday: event.birthday,
        aid: event.aid,
        password: event.password,
      );
      await _fileApi.moveFileToAppDir(event.imagePath, newMeta.id);

      emit(KeyFormLoadOnSuccess(newMeta));
    } on LocalDatabaseException {
      emit(const KeyFormLoadOnFailure());
    }
  }

  Future<void> _onKeyFormUpdateEvent(
    KeyFormUpdateEvent event,
    Emitter<KeyFormState> emit,
  ) async {
    emit(const KeyFormLoadInProgress());

    try {
      final id = event.id;
      // ignore: avoid-dynamic, since we want to parallelize these futures.
      final [newMeta, _] = await Future.wait<dynamic>([
        _localDatabaseApi.updateKey(
          id: id,
          name: event.name,
          birthday: event.birthday,
          aid: event.aid,
          password: event.password,
        ),
        _fileApi.moveFileToAppDir(event.imagePath, id),
      ]);

      emit(KeyFormLoadOnSuccess(newMeta as GiftKeyMeta));
    } on LocalDatabaseException {
      emit(const KeyFormLoadOnFailure());
    }
  }

  Future<void> _onKeyFormDeleteEvent(
    KeyFormDeleteEvent event,
    Emitter<KeyFormState> emit,
  ) async {
    emit(const KeyFormLoadInProgress());

    try {
      final id = event.id;
      await Future.wait([
        _localDatabaseApi.deleteKey(id),
        _fileApi.deleteImage(id),
      ]);

      emit(KeyFormDeleteOnSuccess(id));
    } on LocalDatabaseException {
      emit(const KeyFormLoadOnFailure());
    }
  }
}
