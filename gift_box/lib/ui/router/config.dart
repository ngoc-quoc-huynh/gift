import 'package:flutter/widgets.dart';
import 'package:gift_box/ui/pages/error/page.dart';
import 'package:gift_box/ui/pages/gift/page.dart';
import 'package:gift_box/ui/pages/home/page.dart';
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
      true => '/',
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
        name: Routes.homePage(),
        path: '/',
        builder: (_, _) => const HomePage(),
      ),
    ],
  );
}
