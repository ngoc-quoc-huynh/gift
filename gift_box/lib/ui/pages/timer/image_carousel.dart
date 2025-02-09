import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/utils/extensions/list.dart';
import 'package:gift_box/static/resources/assets.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselView(
      itemExtent: double.infinity,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      enableSplash: false,
      itemSnapping: true,
      children: (Assets.items..shuffleSeeded()).map(_Item.new).toList(),
    );
  }
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
