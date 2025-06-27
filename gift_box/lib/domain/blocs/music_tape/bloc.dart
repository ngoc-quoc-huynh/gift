import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:gift_box/injector.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'event.dart';

final class MusicTapeBloc extends HydratedBloc<MusicTapeEvent, bool> {
  MusicTapeBloc() : _audioPlayer = Injector.instance.audioPlayer, super(false) {
    on<MusicTapeInitializeEvent>(
      _onMusicTapeInitializeEvent,
      transformer: droppable(),
    );
    on<MusicTapePlayEvent>(
      _onMusicTapePlayEvent,
      transformer: droppable(),
    );
    on<MusicTapeStopEvent>(
      _onMusicTapeStopEvent,
      transformer: droppable(),
    );
  }

  final AudioPlayer _audioPlayer;
  static const _storageKey = 'music_tape';

  Future<void> _onMusicTapeInitializeEvent(
    MusicTapeInitializeEvent event,
    Emitter<bool> emit,
  ) async {
    await _audioPlayer.setLoopMode(LoopMode.all);

    if (state) {
      add(const MusicTapePlayEvent());
    }
  }

  Future<void> _onMusicTapePlayEvent(
    MusicTapePlayEvent event,
    Emitter<bool> emit,
  ) async {
    await _audioPlayer.setAsset('assets/audios/ada/unlock.mp3');
    unawaited(_audioPlayer.play());
    emit(true);
  }

  Future<void> _onMusicTapeStopEvent(
    MusicTapeStopEvent event,
    Emitter<bool> emit,
  ) async {
    await _audioPlayer.stop();
    emit(false);
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json[_storageKey] as bool;

  @override
  Map<String, dynamic>? toJson(bool state) => {
    _storageKey: state,
  };

  @override
  Future<void> close() async {
    await _audioPlayer.dispose();
    return super.close();
  }
}
