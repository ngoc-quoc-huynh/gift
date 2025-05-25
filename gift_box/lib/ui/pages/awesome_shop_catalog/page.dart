import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/customizer.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/equipment.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/specials.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';

class AwesomeShopCatalogPage extends StatelessWidget {
  const AwesomeShopCatalogPage({super.key});

  static final _destinations = [
    AwesomeShopSpecialsDestination.new,
    AwesomeShopCustomizerDestination.new,
    AwesomeShopEquipmentDestination.new,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBarCubit>(
      create: (_) => NavigationBarCubit(NavigationBarState.specials),
      child: Scaffold(
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
        bottomNavigationBar:
            BlocBuilder<NavigationBarCubit, NavigationBarState>(
              builder: (context, state) => NavigationBar(
                selectedIndex: state.index,
                onDestinationSelected: (index) => context
                    .read<NavigationBarCubit>()
                    .update(NavigationBarState.values[index]),
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
            ),
        body: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: CouponDisplay.large(amount: 10),
            ),
            Expanded(
              child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
                builder: (context, state) => _destinations[state.index](),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TranslationsPagesAwesomeShopCatalogEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog;
}
