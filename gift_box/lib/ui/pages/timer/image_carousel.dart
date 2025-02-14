import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/image_carousel/cubit.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/utils/extensions/list.dart';
import 'package:gift_box/static/config.dart';
import 'package:gift_box/static/resources/assets.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = CarouselController();
  late double _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.sizeOf(context).width;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCarouselCubit>(
      create: (_) => ImageCarouselCubit(
        count: Assets.items.length,
        imageDuration: Config.carouselImageDuration,
      )..init(),
      child: BlocListener<ImageCarouselCubit, ImageCarouselState>(
        listener: _onImageCarouselStateChange,
        child: IgnorePointer(
          // TODO: Change logic if https://github.com/flutter/flutter/issues/161369 is resolved.
          child: CarouselView(
            controller: _controller,
            itemExtent: double.infinity,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(),
            enableSplash: false,
            itemSnapping: true,
            children: (Assets.items..shuffleSeeded()).map(_Item.new).toList(),
          ),
        ),
      ),
    );
  }

  void _onImageCarouselStateChange(
    BuildContext _,
    ImageCarouselState state,
  ) =>
      unawaited(
        // TODO: Change if https://github.com/flutter/flutter/issues/161368 is resolved.
        _controller.animateTo(
          _screenWidth * state.index,
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
    return Image.asset(
      asset(),
      fit: BoxFit.cover,
    );
  }
}
