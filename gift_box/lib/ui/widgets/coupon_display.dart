import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';

class CouponDisplay extends StatelessWidget {
  const CouponDisplay.large({required this.amount, super.key}) : height = 40;

  const CouponDisplay.small({required this.amount, super.key}) : height = 30;

  final int amount;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomAssetImage(
          asset: Asset.ficsitCoupon,
          height: height,
        ),
        const SizedBox(width: 10),
        Text(
          _translations.couponAmount(n: amount),
          style: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static TranslationsWidgetsEn get _translations =>
      Injector.instance.translations.widgets;
}
