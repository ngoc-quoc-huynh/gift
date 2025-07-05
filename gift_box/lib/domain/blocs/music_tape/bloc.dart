import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:gift_box/domain/utils/extensions/list.dart';
import 'package:gift_box/injector.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'event.dart';

final class MusicTapeBloc extends HydratedBloc<MusicTapeEvent, bool> {
  MusicTapeBloc() : super(false) {
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

  static final _nativeApi = Injector.instance.nativeApi;
  static const _storageKey = 'music_tape';

  AudioPlayer? _audioPlayer;
  late final List<String> _assets;

  Future<void> _onMusicTapeInitializeEvent(
    MusicTapeInitializeEvent event,
    Emitter<bool> emit,
  ) async {
    _assets = await _nativeApi.loadMusicTape();
    if (state) {
      add(const MusicTapePlayEvent());
    }
  }

  Future<void> _onMusicTapePlayEvent(
    MusicTapePlayEvent event,
    Emitter<bool> emit,
  ) async {
    await _disposeAudioPlayer();
    _audioPlayer = AudioPlayer();
    await [
      _audioPlayer!.setLoopMode(LoopMode.all),
      _audioPlayer!.setAudioSources(
        _assets.map(AudioSource.asset).toList(growable: false)..shuffleSeeded(),
      ),
    ].wait;
    unawaited(_audioPlayer!.play());
    emit(true);
  }

  Future<void> _onMusicTapeStopEvent(
    MusicTapeStopEvent event,
    Emitter<bool> emit,
  ) async {
    await _disposeAudioPlayer();
    emit(false);
  }

  Future<void> _disposeAudioPlayer() async {
    await _audioPlayer?.dispose();
    _audioPlayer = null;
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json[_storageKey] as bool;

  @override
  Map<String, dynamic>? toJson(bool state) => {
    _storageKey: state,
  };

  @override
  Future<void> close() async {
    await _disposeAudioPlayer();
    return super.close();
  }
}
