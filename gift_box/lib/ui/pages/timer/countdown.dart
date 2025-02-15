import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/countdown/cubit.dart';
import 'package:gift_box/domain/utils/extensions/duration.dart';
import 'package:gift_box/injector.dart';

class TimerCountdown extends StatelessWidget {
  const TimerCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: FittedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ColoredBox(
              color: theme.colorScheme.surface.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Center(
                  child: BlocProvider<CountdownCubit>(
                    create: (_) =>
                        CountdownCubit(Injector.instance.birthday)..init(),
                    child: const _Text(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
          letterSpacing: 1.5,
        );

    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) => switch (state) {
        CountdownLoadInProgress() => const SizedBox.shrink(),
        CountdownRunning(:final remainingTime) => Text(
            remainingTime.toHHMMSS(),
            style: textStyle,
          ),
        CountdownFinished() => Text(
            Injector.instance.translations.pages.timer.tapMe,
            style: textStyle,
          ),
      },
    );
  }
}
