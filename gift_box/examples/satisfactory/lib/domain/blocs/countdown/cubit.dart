import 'dart:async';

import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/injector.dart';

part 'state.dart';

final class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit(this.date) : super(const CountdownLoadInProgress());

  final DateTime date;

  Timer? _timer;

  void init() {
    _timer?.cancel();
    _tick();
    _timer = Injector.instance.periodicTimer(
      const Duration(seconds: 1),
      (_) => _tick(),
    );
  }

  void _tick() {
    final diff = date.difference(clock.now());

    if (diff <= Duration.zero) {
      _stopTimer();
      emit(const CountdownFinished());
    } else {
      emit(CountdownRunning(diff));
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
