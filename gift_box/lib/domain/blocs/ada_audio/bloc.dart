import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/injector.dart';
import 'package:just_audio/just_audio.dart';

part 'event.dart';
part 'state.dart';

final class AdaAudioBloc extends Bloc<AdaAudioEvent, AdaAudioState> {
  AdaAudioBloc()
    : _audioPlayer = Injector.instance.audioPlayer,
      super(const AdaAudioLoadInProgress()) {
    on<AdaAudioInitializeEvent>(
      _onAdaAudioInitializeEvent,
      transformer: droppable(),
    );
    on<AdaAudioPlayEvent>(
      _onAdaAudioPlayEvent,
      transformer: droppable(),
    );
    on<AdaAudioMonitorPlayerState>(
      _onAdaAudioMonitorPlayerState,
      transformer: droppable(),
    );
  }

  final AudioPlayer _audioPlayer;
  static final _shopApi = Injector.instance.shopApi;

  Future<void> _onAdaAudioInitializeEvent(
    AdaAudioInitializeEvent event,
    Emitter<AdaAudioState> emit,
  ) async {
    final audio = await _shopApi.loadAdaAudio(event.id);
    emit(
      AdaAudioLoadOnSuccess(
        text: audio.transcript.first.text,
        audio: audio,
      ),
    );
    await _audioPlayer.setAsset('assets/audios/ada/unlock.mp3');
    await _audioPlayer.play();
  }

  Future<void> _onAdaAudioPlayEvent(
    AdaAudioPlayEvent event,
    Emitter<AdaAudioState> emit,
  ) async {
    if (state case final AdaAudioLoadOnSuccess state) {
      final audio = state.audio;
      await _audioPlayer.setAsset(audio.asset());
      await _audioPlayer.play();
      add(const AdaAudioMonitorPlayerState());

      await emit.forEach(
        _audioPlayer.positionStream,
        onData: (position) {
          final segment = audio.transcript.lastWhereOrNull(
            (transcript) => position >= transcript.offset,
          );

          return state.copyWith(text: segment?.text);
        },
      );
    }
  }

  Future<void> _onAdaAudioMonitorPlayerState(
    AdaAudioMonitorPlayerState event,
    Emitter<AdaAudioState> emit,
  ) => emit.forEach(
    _audioPlayer.playerStateStream,
    onData: (playerState) => switch (playerState.processingState) {
      ProcessingState.completed => const AdaAudioLoadOnComplete(),
      _ => state,
    },
  );

  @override
  Future<void> close() async {
    await _audioPlayer.dispose();
    return super.close();
  }
}
