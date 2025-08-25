import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/countdown/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/domain/utils/extensions/duration.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/timer/frosted_background.dart';

class TimerCountdown extends StatelessWidget {
  const TimerCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyle = context.textTheme.displayLarge?.copyWith(
      color: theme.colorScheme.surface,
    );

    return BlocProvider<CountdownCubit>(
      create: (_) => CountdownCubit(Injector.instance.birthday)..init(),
      child: BlocBuilder<CountdownCubit, CountdownState>(
        builder: (context, state) => switch (state) {
          CountdownLoadInProgress() => const SizedBox.shrink(),
          CountdownRunning(:final remainingTime) => FrostedBackground(
            child: Text(
              remainingTime.toHHMMSS(),
              style: textStyle?.copyWith(letterSpacing: 1.5),
            ),
          ),
          CountdownFinished() => const _Button(),
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyle = theme.textTheme.displayLarge?.copyWith(
      color: theme.colorScheme.surface,
    );

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () => context.goRoute(AppRoute.gift),
      child: FrostedBackground(
        child: Text(
          Injector.instance.translations.pages.timer.tapMe,
          style: textStyle,
        ),
      ),
    );
  }
}
