import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/ui/pages/add_key/page.dart';
import 'package:gift_keys/ui/pages/key/page.dart';
import 'package:gift_keys/ui/pages/key_metas/page.dart';
import 'package:gift_keys/ui/pages/license/page.dart';
import 'package:gift_keys/ui/pages/settings/page.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:go_router/go_router.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  static final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/keys',
    routes: [
      ShellRoute(
        builder:
            (_, _, child) => BlocProvider<KeyMetasBloc>(
              create:
                  (_) => KeyMetasBloc()..add(const KeyMetasInitializeEvent()),
              child: child,
            ),
        routes: [
          GoRoute(
            name: Routes.keysPage(),
            path: '/keys',
            builder: (_, _) => const KeyMetasPage(),
            routes: [
              GoRoute(
                name: Routes.addKeyPage(),
                path: 'new',
                builder: (_, _) => const AddKeyPage(),
              ),
              GoRoute(
                name: Routes.keyPage(),
                path: ':id',
                builder:
                    (_, state) =>
                        KeyPage(id: int.parse(state.pathParameters['id']!)),
              ),
            ],
          ),
          GoRoute(
            name: Routes.licensePage(),
            path: '/license',
            builder: (_, _) => const CustomLicensePage(),
          ),
          GoRoute(
            name: Routes.settingsPage(),
            path: '/settings',
            builder: (_, _) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}
