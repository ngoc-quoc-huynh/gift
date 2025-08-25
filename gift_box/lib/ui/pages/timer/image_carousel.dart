import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/image_carousel/cubit.dart';
import 'package:gift_box/domain/blocs/images/bloc.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/domain/utils/extensions/list.dart';
import 'package:gift_box/static/config.dart';

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
    return BlocProvider<ImagesBloc>(
      create: (_) => ImagesBloc()..add(const ImagesInitializeEvent()),
      child: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) => switch (state) {
          ImagesLoadInProgress() => const SizedBox.shrink(),
          ImagesLoadOnSuccess(:final paths) => BlocProvider<ImageCarouselCubit>(
            create: (_) => ImageCarouselCubit(
              count: paths.length,
              imageDuration: Config.carouselImageDuration,
            )..init(),
            child: LayoutBuilder(
              builder:
                  (
                    context,
                    constraints,
                  ) => BlocListener<ImageCarouselCubit, ImageCarouselState>(
                    listener: _onImageCarouselStateChange,
                    child: IgnorePointer(
                      // TODO: Change logic if https://github.com/flutter/flutter/issues/161369 is resolved.
                      child: CarouselView(
                        controller: _controller,
                        itemExtent: constraints.maxWidth,
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(),
                        enableSplash: false,
                        itemSnapping: true,
                        children: (paths..shuffleSeeded())
                            .map(_Item.new)
                            .toList(),
                      ),
                    ),
                  ),
            ),
          ),
        },
      ),
    );
  }

  void _onImageCarouselStateChange(
    BuildContext _,
    ImageCarouselState state,
  ) => unawaited(
    _controller.animateToItem(
      state.index,
      duration: Config.carouselAnimationDuration,
      curve: Curves.easeInOut,
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item(this.path);

  final String path;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black
                .harmonizeWith(theme.colorScheme.primary)
                .withValues(
                  alpha: switch (theme.brightness) {
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
