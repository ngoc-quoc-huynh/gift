import 'package:flutter/material.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/colors.dart';

class AwesomeShopCatalogPurchased extends StatelessWidget {
  const AwesomeShopCatalogPurchased({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        const Icon(
          Icons.check,
          color: CustomColors.orange,
        ),
        Text(
          Injector.instance.translations.pages.awesomeShopCatalog.purchased,
          style: context.textTheme.bodyLarge?.copyWith(
            color: CustomColors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
