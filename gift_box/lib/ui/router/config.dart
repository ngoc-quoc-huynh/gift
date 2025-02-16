import 'package:flutter/widgets.dart';
import 'package:gift_box/ui/pages/gift/page.dart';
import 'package:gift_box/ui/pages/timer/page.dart';
import 'package:gift_box/ui/router/routes.dart';
import 'package:go_router/go_router.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/timer',
    routes: [
      GoRoute(
        name: Routes.timerPage(),
        path: '/timer',
        builder: (_, __) => const TimerPage(),
      ),
      GoRoute(
        name: Routes.giftPage(),
        path: '/gift',
        builder: (_, __) => const GiftPage(),
      ),
    ],
  );
}
