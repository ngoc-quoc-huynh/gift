import 'package:flutter/material.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';

class ShopCatalogPurchased extends StatelessWidget {
  const ShopCatalogPurchased({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final primaryColor = theme.colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Icon(
          Icons.check,
          color: primaryColor,
        ),
        Text(
          Injector.instance.translations.pages.shopCatalog.purchased,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
