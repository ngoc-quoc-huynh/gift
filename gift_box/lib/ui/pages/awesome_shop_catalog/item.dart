import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';

class AwesomeShopCatalogItem extends StatelessWidget {
  const AwesomeShopCatalogItem({required this.meta, super.key});

  final AwesomeShopItemMeta meta;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    const fontWeight = FontWeight.w600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Card(
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Column(
                  spacing: 20,
                  children: [
                    SizedBox(height: meta.height / 2),
                    Text(
                      meta.name,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: fontWeight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(thickness: 2),
                    CouponDisplay.small(amount: meta.price),
                  ],
                ),
                Positioned(
                  top: -meta.height / 2,
                  child: CustomAssetImage(
                    asset: meta.asset,
                    height: meta.height,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
