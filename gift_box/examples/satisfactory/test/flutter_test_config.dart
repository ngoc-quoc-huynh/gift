import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_satisfactory/static/resources/theme.dart';

Future<void> testExecutable(
  FutureOr<void> Function() testMain,
) async => AlchemistConfig.runWithConfig(
  config: AlchemistConfig(
    theme: CustomTheme.light,
    platformGoldensConfig: const PlatformGoldensConfig(
      // ignore: avoid_redundant_argument_values, will be true running on CI.
      enabled: !bool.fromEnvironment('CI'),
    ),
  ),
  run: () {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;
    goldenFileComparator = _LocalFileComparatorWithThreshold(
      Uri.parse('$testUrl/test.dart'),
      0.001,
    );

    return testMain();
  },
);

class _LocalFileComparatorWithThreshold extends LocalFileComparator {
  _LocalFileComparatorWithThreshold(super.testFile, this.threshold)
    : assert(
        threshold >= 0 && threshold <= 1,
        'Threshold must be between 0 and 1! ',
      );

  final double threshold;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent <= threshold) {
      debugPrint(
        'A difference of ${result.diffPercent * 100}% was found, but it is '
        'acceptable since it is not greater than the threshold of '
        '${threshold * 100}%.',
      );

      return true;
    }

    if (!result.passed) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }

    return result.passed;
  }
}
