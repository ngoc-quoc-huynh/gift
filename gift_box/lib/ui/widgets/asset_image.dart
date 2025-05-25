import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';

class CustomAssetImage extends StatelessWidget {
  const CustomAssetImage({
    required this.asset,
    required this.height,
    super.key,
  });

  final Asset asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset(),
      height: height,
      fit: BoxFit.contain,
    );
  }
}
