import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys/bloc.dart';
import 'package:gift_keys/ui/pages/add_key/page.dart';
import 'package:gift_keys/ui/pages/key/page.dart';
import 'package:gift_keys/ui/pages/keys/page.dart';
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
            (_, _, child) => BlocProvider<KeysBloc>(
              create: (_) => KeysBloc()..add(const KeysInitializeEvent()),
              child: child,
            ),
        routes: [
          GoRoute(
            name: Routes.keysPage(),
            path: '/keys',
            builder: (_, _) => const KeysPage(),
            routes: [
              GoRoute(
                name: Routes.addKeyPage(),
                path: 'add',
                builder: (_, _) => const AddKeyPage(),
              ),
              GoRoute(
                name: Routes.keyPage(),
                path: ':id',
                builder:
                    (_, state) =>
                        KeyPage(id: state.pathParameters['id']! as int),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
