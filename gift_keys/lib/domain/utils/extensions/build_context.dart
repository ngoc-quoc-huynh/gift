import 'dart:async';

import 'package:flutter/material.dart' hide Route;
import 'package:gift_keys/domain/models/route.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => ColorScheme.of(this);

  DialogThemeData get dialogTheme => DialogTheme.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => TextTheme.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  void goRoute(
    Route route, {
    Map<String, String> pathParameters = const <String, String>{},
  }) => goNamed(route(), pathParameters: pathParameters);

  void pushRoute(Route route) => unawaited(pushNamed(route()));
}
