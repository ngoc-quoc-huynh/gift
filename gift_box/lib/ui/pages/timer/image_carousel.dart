import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/image_carousel/cubit.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/domain/utils/extensions/list.dart';
import 'package:gift_box/static/config.dart';
import 'package:gift_box/static/resources/assets.dart';

class TimerImageCarousel extends StatefulWidget {
  const TimerImageCarousel({super.key});

  @override
  State<TimerImageCarousel> createState() => _TimerImageCarouselState();
}

class _TimerImageCarouselState extends State<TimerImageCarousel> {
  final _controller = CarouselController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCarouselCubit>(
      create: (_) => ImageCarouselCubit(
        count: Assets.images.length,
        imageDuration: Config.carouselImageDuration,
      )..init(),
      child: LayoutBuilder(
        builder:
            (
              context,
              constraints,
            ) => BlocListener<ImageCarouselCubit, ImageCarouselState>(
              listener: (_, state) => _onImageCarouselStateChange(
                state: state,
                maxWidth: constraints.maxWidth,
              ),
              child: IgnorePointer(
                // TODO: Change logic if https://github.com/flutter/flutter/issues/161369 is resolved.
                child: CarouselView(
                  controller: _controller,
                  itemExtent: constraints.maxWidth,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(),
                  enableSplash: false,
                  itemSnapping: true,
                  children: (Assets.images..shuffleSeeded())
                      .map(_Item.new)
                      .toList(),
                ),
              ),
            ),
      ),
    );
  }

  void _onImageCarouselStateChange({
    required ImageCarouselState state,
    required double maxWidth,
  }) => unawaited(
    // TODO: Change if https://github.com/flutter/flutter/issues/161368 is resolved.
    _controller.animateTo(
      maxWidth * state.index,
      duration: Config.carouselAnimationDuration,
      curve: Curves.easeInOut,
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item(this.asset);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(asset()),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(
              alpha: switch (context.theme.brightness) {
                Brightness.light => 0,
                Brightness.dark => 0.2,
              },
            ),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }
}
