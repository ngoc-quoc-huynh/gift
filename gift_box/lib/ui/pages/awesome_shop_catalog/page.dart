import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';
import 'package:go_router/go_router.dart';

class AwesomeShopCatalogPage extends StatelessWidget {
  const AwesomeShopCatalogPage({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

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
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: navigationShell.currentIndex == index,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.local_offer_outlined),
            selectedIcon: const Icon(Icons.local_offer_rounded),
            label: _translations.navigationBar.specials,
            tooltip: _translations.navigationBar.specials,
          ),
          NavigationDestination(
            icon: const Icon(Icons.palette_outlined),
            selectedIcon: const Icon(Icons.palette_rounded),
            label: _translations.navigationBar.customizer,
            tooltip: _translations.navigationBar.customizer,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_cafe_outlined),
            selectedIcon: const Icon(Icons.local_cafe_rounded),
            label: _translations.navigationBar.equipment,
            tooltip: _translations.navigationBar.equipment,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: BlocBuilder<HydratedIntCubit, int>(
                builder: (context, amount) =>
                    CouponDisplay.animated(amount: amount),
              ),
            ),
          ),
          Expanded(
            child: children[navigationShell.currentIndex],
          ),
        ],
      ),
    );
  }

  TranslationsPagesAwesomeShopCatalogEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog;
}
