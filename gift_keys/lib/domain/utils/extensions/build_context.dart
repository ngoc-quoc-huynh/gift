import 'package:flutter/material.dart' hide Route;
import 'package:gift_keys/domain/models/route.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  void goRoute(Route route) => goNamed(route());
}
