import 'package:flutter/widgets.dart';
import 'package:gift_keys/ui/pages/home/page.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:go_router/go_router.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: Routes.homePage(),
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
    ],
  );
}
