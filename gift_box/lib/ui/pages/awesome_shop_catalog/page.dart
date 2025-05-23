import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';

class AwesomeShopCatalogPage extends StatelessWidget {
  const AwesomeShopCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_translations.appBar),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: _translations.settingsTooltip,
            onPressed: () => context.pushRoute(AppRoute.settings),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.local_offer_outlined),
            label: _translations.navigationBar.specials,
          ),
          NavigationDestination(
            icon: const Icon(Icons.palette_outlined),
            label: _translations.navigationBar.customizer,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_cafe_outlined),
            label: _translations.navigationBar.equipment,
          ),
        ],
      ),
    );
  }

  TranslationsPagesAwesomeShopCatalogEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog;
}
