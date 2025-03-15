import 'package:flutter/material.dart' hide Route;
import 'package:gift_keys/domain/models/route.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  void goRoute(
    Route route, {
    Map<String, String> pathParameters = const <String, String>{},
  }) => goNamed(route(), pathParameters: pathParameters);

  ColorScheme get colorScheme => ColorScheme.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => TextTheme.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);
}
