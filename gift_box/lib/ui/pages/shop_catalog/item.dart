import 'package:flutter/material.dart' hide Route;
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/models/shop_item_meta.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/ui/pages/shop_catalog/purchased.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';

class ShopCatalogItem extends StatelessWidget {
  const ShopCatalogItem({
    required this.meta,
    required this.detailRoute,
    super.key,
  });

  final ShopItemMeta meta;
  final AppRoute detailRoute;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    const fontWeight = FontWeight.w600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Card(
          child: IgnorePointer(
            ignoring: meta.isPurchased,
            child: InkWell(
              onTap: () => context.goRoute(
                detailRoute,
                pathParameters: {'id': meta.id},
              ),
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
                        switch (meta.isPurchased) {
                          false => CouponDisplay.small(amount: meta.price),
                          true => const ShopCatalogPurchased(),
                        },
                      ],
                    ),
                    Positioned(
                      top: -meta.height / 2,
                      child: CustomAssetImage(
                        asset: meta.asset,
                        height: meta.height,
                        isDisabled: meta.isPurchased,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
