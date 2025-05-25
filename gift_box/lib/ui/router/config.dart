import 'package:flutter/widgets.dart';
import 'package:gift_box/ui/pages/awesome_shop/page.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/page.dart';
import 'package:gift_box/ui/pages/awesome_shop_item/page.dart';
import 'package:gift_box/ui/pages/awesome_sink/page.dart';
import 'package:gift_box/ui/pages/error/page.dart';
import 'package:gift_box/ui/pages/gift/page.dart';
import 'package:gift_box/ui/pages/settings/page.dart';
import 'package:gift_box/ui/pages/timer/page.dart';
import 'package:gift_box/ui/router/routes.dart';
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
        name: Routes.timerPage(),
        path: '/timer',
        builder: (_, _) => const TimerPage(),
        routes: [
          GoRoute(
            name: Routes.giftPage(),
            path: 'gift',
            builder: (_, _) => const GiftPage(),
          ),
        ],
      ),
      GoRoute(
        name: Routes.awesomeSink(),
        path: '/awesome-sink',
        builder: (_, _) => const AwesomeSinkPage(),
      ),
      GoRoute(
        name: Routes.awesomeShop(),
        path: '/awesome-shop',
        builder: (_, _) => const AwesomeShopPage(),
        routes: [
          GoRoute(
            name: Routes.awesomeShopCatalog(),
            path: 'catalog',
            builder: (_, _) => const AwesomeShopCatalogPage(),
            routes: [
              GoRoute(
                name: Routes.awesomeShopItem(),
                path: ':id',
                builder: (_, state) =>
                    AwesomeShopItemPage(id: state.pathParameters['id']!),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: Routes.settingsPage(),
        path: '/settings',
        builder: (_, _) => const SettingsPage(),
      ),
    ],
  );
}
