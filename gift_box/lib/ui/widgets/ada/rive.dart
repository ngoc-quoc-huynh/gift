import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/widgets/rive_player.dart';
import 'package:rive_native/rive_native.dart';

class AdaRive extends StatelessWidget {
  const AdaRive({super.key});

  static const _height = 100.0;
  static const _startScale = 1.0;
  static const _endScale = 0.3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoubleCubit, double>(
      builder: (context, textHeight) => Transform.translate(
        offset: Offset(
          0,
          (-_height / 2) - textHeight,
        ),
        child: BlocBuilder<BoolCubit, bool>(
          builder: (context, isAnimationComplete) => AnimatedScale(
            scale: switch (isAnimationComplete) {
              false => _startScale,
              true => _endScale,
            },
            curve: Sizes.adaAnimationCurve,
            duration: Sizes.adaAnimationDuration,
            child: const _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AdaRive._height,
      child: RivePlayer(
        asset: Asset.satisfactory(),
        artboardName: 'ADA',
        onLoaded: (stateMachine) => _onInit(context, stateMachine),
      ),
    );
  }

  void _onInit(BuildContext context, StateMachine stateMachine) =>
      stateMachine.addEventListener(
        (event) => _onRiveEvent(context, event),
      );

  void _onRiveEvent(BuildContext context, Event event) => switch (event.name) {
    'Animation end event' => context.read<BoolCubit>().update(true),
    String() => null,
  };
}
