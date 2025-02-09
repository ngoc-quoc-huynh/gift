import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:gift_box/static/resources/theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async =>
    AlchemistConfig.runWithConfig(
      config: AlchemistConfig(
        theme: CustomTheme.light,
        platformGoldensConfig: const PlatformGoldensConfig(
          // ignore: avoid_redundant_argument_values, will be true running on CI.
          enabled: !bool.fromEnvironment('CI'),
        ),
      ),
      run: () => testMain(),
    );
