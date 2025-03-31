import 'package:flutter/material.dart' hide Route;
import 'package:gift_box/domain/models/route.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => ColorScheme.of(this);

  TextTheme get textTheme => TextTheme.of(this);

  void goRoute(Route route) => goNamed(route());
}
