import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:go_router/go_router.dart';

class ShopItemConfirmationDialog extends StatelessWidget {
  const ShopItemConfirmationDialog({
    required this.name,
    required this.price,
    super.key,
  });

  final String name;
  final int price;

  static Future<bool> show({
    required BuildContext context,
    required String name,
    required int price,
  }) async {
    final hasBought = await showDialog<bool>(
      context: context,
      builder: (_) => ShopItemConfirmationDialog(
        price: price,
        name: name,
      ),
    );

    return hasBought ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_translations.title(name: name)),
      content: Text(
        _translations.content(price: price, name: name),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(_translations.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(_translations.buy),
        ),
      ],
    );
  }

  static TranslationsPagesShopItemConfirmationDialogEn get _translations =>
      Injector.instance.translations.pages.shopItem.confirmationDialog;
}
