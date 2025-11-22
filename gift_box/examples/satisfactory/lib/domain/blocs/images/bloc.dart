import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/injector.dart';

part 'event.dart';
part 'state.dart';

final class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(const ImagesLoadInProgress()) {
    on<ImagesInitializeEvent>(
      _onImagesInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _nativeApi = Injector.instance.nativeApi;

  Future<void> _onImagesInitializeEvent(
    ImagesInitializeEvent event,
    Emitter<ImagesState> emit,
  ) async {
    final paths = await _nativeApi.loadImagePaths();
    emit(ImagesLoadOnSuccess(paths));
  }
}
