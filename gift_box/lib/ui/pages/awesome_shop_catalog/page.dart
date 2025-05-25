import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';

class AwesomeShopCatalogPage extends StatelessWidget {
  const AwesomeShopCatalogPage({super.key});

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
      ),
    );
  }

  TranslationsPagesAwesomeShopCatalogEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog;
}
