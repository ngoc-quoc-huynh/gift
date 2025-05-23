import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/countdown/cubit.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/domain/utils/extensions/duration.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/router/routes.dart';
import 'package:gift_box/ui/widgets/frosted_card.dart';

class TimerCountdown extends StatelessWidget {
  const TimerCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: FrostedCard(
          child: BlocProvider<CountdownCubit>(
            create: (_) => CountdownCubit(Injector.instance.birthday)..init(),
            child: const _Text(),
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
    final theme = context.theme;
    final brightness = theme.brightness;
    final colorScheme = theme.colorScheme;
    final textColor = switch (brightness) {
      Brightness.light => colorScheme.surface,
      Brightness.dark => colorScheme.inverseSurface,
    };
    final textStyle = context.textTheme.displayLarge?.copyWith(
      color: textColor,
    );

    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) => switch (state) {
        CountdownLoadInProgress() => const SizedBox.shrink(),
        CountdownRunning(:final remainingTime) => Text(
          remainingTime.toHHMMSS(),
          style: textStyle?.copyWith(letterSpacing: 1.5),
        ),
        CountdownFinished() => TextButton(
          style: TextButton.styleFrom(overlayColor: Colors.transparent),
          onPressed: () => context.goRoute(Routes.giftPage),
          child: Text(
            Injector.instance.translations.pages.timer.tapMe,
            style: textStyle,
          ),
        ),
      },
    );
  }
}
