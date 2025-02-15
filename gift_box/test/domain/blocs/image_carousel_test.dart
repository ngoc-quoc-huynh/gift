import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/image_carousel/cubit.dart';
import 'package:gift_box/injector.dart';

import '../../utils.dart';

void main() {
  test(
    'initial state is ImageCarouselState(index: 0, isReverse: false).',
    () => expect(
      ImageCarouselCubit(count: 2, imageDuration: Duration.zero).state,
      const ImageCarouselState(
        index: 0,
        isReverse: false,
      ),
    ),
  );

  test('cubit creation throws AssertionError if count is less than 1.', () {
    expect(
      () => ImageCarouselCubit(count: 1, imageDuration: Duration.zero),
      throwsA(
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'count must be at least two.',
        ),
      ),
    );
    expect(
      () => ImageCarouselCubit(count: 0, imageDuration: Duration.zero),
      throwsA(
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'count must be at least two.',
        ),
      ),
    );
    expect(
      () => ImageCarouselCubit(count: -1, imageDuration: Duration.zero),
      throwsA(
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'count must be at least two.',
        ),
      ),
    );
  });

  group('init', () {
    blocTest<ImageCarouselCubit, ImageCarouselState>(
      'emits nothing if timer is not triggered.',
      setUp: Injector.instance.registerPeriodicTimer,
      tearDown: Injector.instance.unregister<Timer>,
      build: () => ImageCarouselCubit(
        count: 2,
        imageDuration: const Duration(seconds: 1),
      ),
      act: (cubit) => cubit.init(),
      expect: () => const <ImageCarouselState>[],
    );

    blocTest<ImageCarouselCubit, ImageCarouselState>(
      'emits correctly if when index is not the last and timer is triggered.',
      setUp: Injector.instance.registerPeriodicTimer,
      tearDown: Injector.instance.unregister<Timer>,
      build: () => ImageCarouselCubit(
        count: 2,
        imageDuration: const Duration(seconds: 1),
      ),
      act: (cubit) => cubit.init(),
      wait: const Duration(seconds: 1),
      expect: () => [const ImageCarouselState(index: 1, isReverse: false)],
    );

    blocTest<ImageCarouselCubit, ImageCarouselState>(
      'emits correctly when index is the last and timer is triggered.',
      setUp: Injector.instance.registerPeriodicTimer,
      tearDown: Injector.instance.unregister<Timer>,
      build: () => ImageCarouselCubit(
        count: 2,
        imageDuration: const Duration(seconds: 1),
      ),
      seed: () => const ImageCarouselState(index: 1, isReverse: false),
      act: (cubit) => cubit.init(),
      wait: const Duration(seconds: 1),
      expect: () => const [ImageCarouselState(index: 0, isReverse: true)],
    );

    blocTest<ImageCarouselCubit, ImageCarouselState>(
      'emits correctly when index is the first, isReverse is set and timer is '
      'triggered.',
      setUp: Injector.instance.registerPeriodicTimer,
      tearDown: Injector.instance.unregister<Timer>,
      build: () => ImageCarouselCubit(
        count: 2,
        imageDuration: const Duration(seconds: 1),
      ),
      seed: () => const ImageCarouselState(index: 0, isReverse: true),
      act: (cubit) => cubit.init(),
      wait: const Duration(seconds: 1),
      expect: () => const [ImageCarouselState(index: 1, isReverse: false)],
    );
  });
}
