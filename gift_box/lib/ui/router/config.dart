import 'package:flutter/widgets.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/awesome_shop/page.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/page.dart';
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

  static GoRouter build({required bool hasOpenedGift}) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: switch (hasOpenedGift) {
      false => '/timer',
      true => '/awesome-shop',
    },
    errorBuilder: (_, state) => ErrorPage(url: state.matchedLocation),
    routes: [
      GoRoute(
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
      ),
      GoRoute(
        name: AppRoute.awesomeSink(),
        path: '/awesome-sink',
        builder: (_, _) => const AwesomeSinkPage(),
      ),
      GoRoute(
        name: AppRoute.awesomeShop(),
        path: '/awesome-shop',
        builder: (_, _) => const AwesomeShopPage(),
        routes: [
          GoRoute(
            name: AppRoute.awesomeShopCatalog(),
            path: 'catalog',
            builder: (_, _) => const AwesomeShopCatalogPage(),
          ),
        ],
      ),
      GoRoute(
        name: AppRoute.settings(),
        path: '/settings',
        builder: (_, _) => const SettingsPage(),
      ),
    ],
  );
}
