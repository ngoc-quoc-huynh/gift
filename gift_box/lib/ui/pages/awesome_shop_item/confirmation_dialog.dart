import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';
import 'package:go_router/go_router.dart';

class AwesomeShopItemConfirmationDialog extends StatelessWidget {
  const AwesomeShopItemConfirmationDialog({
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
      builder: (_) => AwesomeShopItemConfirmationDialog(
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

  static TranslationsPagesAwesomeShopItemConfirmationDialogEn
  get _translations =>
      Injector.instance.translations.pages.awesomeShopItem.confirmationDialog;
}
