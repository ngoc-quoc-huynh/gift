import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/awesome_shop_item_metas/bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/awesome_shop/page.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/customizer.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/equipment.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/specials.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/page.dart';
import 'package:gift_box/ui/pages/awesome_shop_detail/page.dart';
import 'package:gift_box/ui/pages/awesome_sink/page.dart';
import 'package:gift_box/ui/pages/error/page.dart';
import 'package:gift_box/ui/pages/gift/page.dart';
import 'package:gift_box/ui/pages/settings/page.dart';
import 'package:gift_box/ui/pages/timer/page.dart';
import 'package:go_router/go_router.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  static final _shopKey = GlobalKey<NavigatorState>(debugLabel: 'shop');

  static GoRouter build({required bool hasOpenedGift}) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: switch (hasOpenedGift) {
      false => '/timer',
      true => '/awesome-shop',
    },
    errorBuilder: (_, state) => ErrorPage(url: state.matchedLocation),
    routes: [
      _timerRoute,
      GoRoute(
        name: AppRoute.awesomeSink(),
        path: '/awesome-sink',
        builder: (_, _) => const AwesomeSinkPage(),
      ),
      _shopRoute,
      GoRoute(
        name: AppRoute.settings(),
        path: '/settings',
        builder: (_, _) => const SettingsPage(),
      ),
    ],
  );

  static final _shopRoute = GoRoute(
    name: AppRoute.awesomeShop(),
    path: '/awesome-shop',
    builder: (_, _) => const AwesomeShopPage(),
    routes: [
      ShellRoute(
        navigatorKey: _shopKey,
        builder: (_, _, child) => MultiBlocProvider(
          providers: [
            BlocProvider<HydratedIntCubit>(
              create: (_) => HydratedIntCubit(
                initialState: 10,
                storageKey: 'coupon_amount',
              ),
            ),
            BlocProvider<AwesomeShopItemMetasCustomizerBloc>(
              create: (_) =>
                  AwesomeShopItemMetasCustomizerBloc()
                    ..add(const AwesomeShopItemMetasInitializeEvent()),
            ),
            BlocProvider<AwesomeShopItemMetasEquipmentBloc>(
              create: (_) =>
                  AwesomeShopItemMetasEquipmentBloc()
                    ..add(const AwesomeShopItemMetasInitializeEvent()),
            ),
            BlocProvider<AwesomeShopItemMetasSpecialsBloc>(
              create: (_) =>
                  AwesomeShopItemMetasSpecialsBloc()
                    ..add(const AwesomeShopItemMetasInitializeEvent()),
            ),
          ],
          child: child,
        ),
        routes: [
          StatefulShellRoute(
            builder: (_, _, child) => child,
            navigatorContainerBuilder: (_, navigationShell, children) =>
                AwesomeShopCatalogPage(
                  navigationShell: navigationShell,
                  children: children,
                ),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.awesomeShopSpecials(),
                    path: 'specials',
                    builder: (_, _) => const AwesomeShopSpecialsDestination(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _shopKey,
                        name: AppRoute.awesomeShopSpecialsDetail(),
                        path: ':id',
                        builder: (_, state) => AwesomeShopSpecialsDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.awesomeShopCustomizer(),
                    path: 'customizer',
                    builder: (_, _) => const AwesomeShopCustomizerDestination(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _shopKey,
                        name: AppRoute.awesomeShopCustomizerDetail(),
                        path: ':id',
                        builder: (_, state) => AwesomeShopCustomizerDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.awesomeShopEquipment(),
                    path: 'equipment',
                    builder: (_, _) => const AwesomeShopEquipmentDestination(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _shopKey,
                        name: AppRoute.awesomeShopEquipmentDetail(),
                        path: ':id',
                        builder: (_, state) => AwesomeShopEquipmentsDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static final _timerRoute = GoRoute(
    name: AppRoute.timer(),
    path: '/timer',
    builder: (_, _) => const TimerPage(),
    routes: [
      GoRoute(
        name: AppRoute.gift(),
        path: 'gift',
        builder: (_, _) => const GiftPage(),
      ),
    ],
  );
}
