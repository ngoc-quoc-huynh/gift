import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/ada_audio/bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box/domain/blocs/shop_item_metas_reset/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/error/page.dart';
import 'package:gift_box/ui/pages/gift/page.dart';
import 'package:gift_box/ui/pages/license/page.dart';
import 'package:gift_box/ui/pages/settings/page.dart';
import 'package:gift_box/ui/pages/shop/page.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/customizer.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/equipment.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/specials.dart';
import 'package:gift_box/ui/pages/shop_catalog/page.dart';
import 'package:gift_box/ui/pages/shop_detail/page.dart';
import 'package:gift_box/ui/pages/sink/page.dart';
import 'package:gift_box/ui/pages/timer/page.dart';
import 'package:gift_box/ui/widgets/ada/overlay.dart';
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
      true => '/shop',
    },
    errorBuilder: (_, state) => ErrorPage(url: state.matchedLocation),
    routes: [
      ShellRoute(
        builder: (_, _, child) => BlocProvider<AdaAudioBloc>(
          create: (_) => AdaAudioBloc(),
          child: AdaOverlay(child: child),
        ),
        routes: [
          _timerRoute,
          GoRoute(
            name: AppRoute.sink(),
            path: '/sink',
            builder: (_, _) => const SinkPage(),
          ),
          _shopRoute,
          GoRoute(
            name: AppRoute.settings(),
            path: '/settings',
            builder: (_, _) => const SettingsPage(),
          ),
          GoRoute(
            name: AppRoute.license(),
            path: '/license',
            builder: (_, _) => const CustomLicensePage(),
          ),
        ],
      ),
    ],
  );

  static final _shopRoute = ShellRoute(
    builder: (_, _, child) => BlocProvider<WelcomeOverlayCubit>(
      create: (_) => WelcomeOverlayCubit(false),
      child: child,
    ),
    routes: [
      GoRoute(
        name: AppRoute.shop(),
        path: '/shop',
        builder: (_, _) => const ShopPage(),
        routes: [
          ShellRoute(
            navigatorKey: _shopKey,
            builder: (_, _, child) => MultiBlocProvider(
              providers: [
                BlocProvider<ShopItemMetasResetBloc>(
                  create: (_) => ShopItemMetasResetBloc(),
                ),
                BlocProvider<HydratedIntCubit>(
                  create: (_) => HydratedIntCubit(
                    initialState: 10,
                    storageKey: 'coupon_amount',
                  ),
                ),
                BlocProvider<ShopItemMetasCustomizerBloc>(
                  create: (_) =>
                      ShopItemMetasCustomizerBloc()
                        ..add(const ShopItemMetasInitializeEvent()),
                ),
                BlocProvider<ShopItemMetasEquipmentBloc>(
                  create: (_) =>
                      ShopItemMetasEquipmentBloc()
                        ..add(const ShopItemMetasInitializeEvent()),
                ),
                BlocProvider<ShopItemMetasSpecialsBloc>(
                  create: (_) =>
                      ShopItemMetasSpecialsBloc()
                        ..add(const ShopItemMetasInitializeEvent()),
                ),
              ],
              child: child,
            ),
            routes: [
              StatefulShellRoute(
                builder: (_, _, child) => child,
                navigatorContainerBuilder: (_, navigationShell, children) =>
                    ShopCatalogPage(
                      navigationShell: navigationShell,
                      children: children,
                    ),
                branches: [
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        name: AppRoute.shopSpecials(),
                        path: 'specials',
                        builder: (_, _) => const ShopSpecialsDestination(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _shopKey,
                            name: AppRoute.shopSpecialsDetail(),
                            path: ':id',
                            builder: (_, state) => ShopSpecialsDetailPage(
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
                        name: AppRoute.shopCustomizer(),
                        path: 'customizer',
                        builder: (_, _) => const ShopCustomizerDestination(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _shopKey,
                            name: AppRoute.shopCustomizerDetail(),
                            path: ':id',
                            builder: (_, state) => ShopCustomizerDetailPage(
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
                        name: AppRoute.shopEquipment(),
                        path: 'equipment',
                        builder: (_, _) => const ShopEquipmentDestination(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _shopKey,
                            name: AppRoute.shopEquipmentDetail(),
                            path: ':id',
                            builder: (_, state) => ShopEquipmentsDetailPage(
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
