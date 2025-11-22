import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';

class CustomAssetImage extends StatelessWidget {
  const CustomAssetImage({
    required this.asset,
    required this.height,
    this.isDisabled = false,
    super.key,
  });

  final Asset asset;
  final double height;
  final bool isDisabled;

  static const _grayscaleMatrix = <double>[
    // @formatter: off
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
    // @formatter: on
  ];

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      asset(),
      height: height,
      fit: BoxFit.contain,
    );

    return switch (isDisabled) {
      false => image,
      true => ColorFiltered(
        colorFilter: const ColorFilter.matrix(_grayscaleMatrix),
        child: image,
      ),
    };
  }
}
