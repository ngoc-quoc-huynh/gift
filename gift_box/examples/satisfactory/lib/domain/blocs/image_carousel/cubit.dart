import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/injector.dart';

part 'state.dart';

final class ImageCarouselCubit extends Cubit<ImageCarouselState> {
  ImageCarouselCubit({required this.count, required this.imageDuration})
    : assert(count > 1, 'count must be at least two.'),
      super(const ImageCarouselState(index: 0, isReverse: false));

  final int count;
  final Duration imageDuration;

  Timer? _timer;

  void init() {
    _cancelTimer();
    _timer = Injector.instance.periodicTimer(
      imageDuration,
      (_) => emit(_computeState()),
    );
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  ImageCarouselState _computeState() => switch (state) {
    ImageCarouselState(:final index, :final isReverse)
        when index == 0 || (index < count + -1 && !isReverse) =>
      ImageCarouselState(index: index + 1, isReverse: false),
    ImageCarouselState(:final index) => ImageCarouselState(
      index: index - 1,
      isReverse: true,
    ),
  };

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}
