import 'package:flutter/material.dart' hide Route;
import 'package:gift_box/domain/models/route.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => ColorScheme.of(this);

  TextTheme get textTheme => TextTheme.of(this);

  ThemeData get theme => Theme.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  void goRoute(AppRoute route) => goNamed(route());

  void pushRoute(AppRoute route) => pushNamed(route());
}
