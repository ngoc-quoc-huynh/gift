import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';

sealed class CouponDisplay extends StatelessWidget {
  const CouponDisplay({required this.amount, super.key});

  const factory CouponDisplay.animated({
    required int amount,
    Key? key,
  }) = _Animated;

  const factory CouponDisplay.small({
    required int amount,
    Key? key,
  }) = _Small;

  const factory CouponDisplay.large({
    required int amount,
    Key? key,
  }) = _Large;

  final int amount;

  @protected
  static TranslationsWidgetsCouponDisplayEn get translations =>
      Injector.instance.translations.widgets.couponDisplay;
}

class _Body extends StatelessWidget {
  const _Body({
    required this.assetHeight,
    required this.builder,
  });

  final double assetHeight;
  final Widget Function(TextStyle?) builder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        CustomAssetImage(
          asset: Asset.ficsitCoupon,
          height: assetHeight,
        ),
        builder.call(
          context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Animated extends CouponDisplay {
  const _Animated({required super.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return _Body(
      assetHeight: 40,
      builder: (style) => AnimatedFlipCounter(
        value: amount,
        prefix: '${CouponDisplay.translations.prefix} ',
        textStyle: style,
        curve: Curves.easeInOutQuad,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _Small extends CouponDisplay {
  const _Small({required super.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return _Body(
      assetHeight: 30,
      builder: (style) => Text(
        CouponDisplay.translations.amount(n: amount),
        style: style,
      ),
    );
  }
}

class _Large extends CouponDisplay {
  const _Large({required super.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return _Body(
      assetHeight: 40,
      builder: (style) => Text(
        CouponDisplay.translations.amount(n: amount),
        style: style,
      ),
    );
  }
}
