import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/injector.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stream_transform/stream_transform.dart';

part 'event.dart';
part 'state.dart';

final class AdaAudioBloc extends Bloc<AdaAudioEvent, AdaAudioState> {
  AdaAudioBloc() : super(const AdaAudioIdle()) {
    on<AdaAudioPlayUnlockEvent>(
      _onAdaAudioPlayUnlockEvent,
      transformer: restartable(),
    );
    on<AdaAudioPlayMainEvent>(
      _onAdaAudioPlayMainEvent,
      transformer: restartable(),
    );
    on<AdaAudioUpdateTranscript>(
      _onAdaAudioUpdateTranscript,
      transformer: restartable(),
    );
  }

  AudioPlayer? _audioPlayer;
  AdaAudio? _audio;
  StreamSubscription<Duration>? _positionSub;
  static final _shopApi = Injector.instance.shopApi;

  Future<void> _onAdaAudioPlayUnlockEvent(
    AdaAudioPlayUnlockEvent event,
    Emitter<AdaAudioState> emit,
  ) async {
    final state = this.state;
    emit(const AdaAudioIdle());

    // We need to wait a tiny moment for the Overlay widget destroy, otherwise
    // the Rive animation will freeze.
    if (state is AdaAudioPlaying) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }

    await _cleanUp();

    if (!await _isUnlocked()) {
      return;
    }

    _audioPlayer = AudioPlayer();

    final audio = _audio = await _shopApi.loadAdaAudio(event.id);
    emit(AdaAudioPlaying(audio.transcript.first.text));

    await _playUnlockAudio();
  }

  Future<void> _onAdaAudioPlayMainEvent(
    AdaAudioPlayMainEvent event,
    Emitter<AdaAudioState> emit,
  ) async {
    if (state is! AdaAudioPlaying) {
      return;
    }

    final audioPlayer = _audioPlayer!;
    await audioPlayer.setAsset(_audio!.asset());
    _setTranscriptUpdates();

    await audioPlayer.play();
    await audioPlayer.waitUntilComplete();

    emit(const AdaAudioIdle());
    await _cleanUp();
  }

  void _onAdaAudioUpdateTranscript(
    AdaAudioUpdateTranscript event,
    Emitter<AdaAudioState> emit,
  ) {
    if (state is AdaAudioPlaying) {
      emit(AdaAudioPlaying(event.text));
    }
  }

  Future<void> _playUnlockAudio() async {
    final audioPlayer = _audioPlayer!;
    await audioPlayer.setAsset('assets/audios/ada/unlock.mp3');
    await audioPlayer.play();
    await audioPlayer.waitUntilComplete();
  }

  Future<bool> _isUnlocked() async {
    final purchasedItems = await _shopApi.loadPurchasedItemIds();
    return purchasedItems.contains(ShopItemId.ada);
  }

  void _setTranscriptUpdates() => _positionSub = _audioPlayer!.positionStream
      .throttle(const Duration(milliseconds: 500))
      .listen((position) {
        final segment = _audio!.transcript.lastWhereOrNull(
          (transcript) => position >= transcript.offset,
        );

        if (segment?.text case final text?) {
          add(AdaAudioUpdateTranscript(text));
        }
      });

  Future<void> _cleanUp() async {
    await Future.wait([
      ?_audioPlayer?.dispose(),
      ?_positionSub?.cancel(),
    ]);
    _audioPlayer = null;
    _audio = null;
    _positionSub = null;
  }

  @override
  Future<void> close() async {
    await _cleanUp();
    return super.close();
  }
}

extension on AudioPlayer {
  Future<void> waitUntilComplete() => processingStateStream.any(
    (state) => state == ProcessingState.completed,
  );
}
