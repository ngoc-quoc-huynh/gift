import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/ada_audio/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/static/resources/sizes.dart';

class AdaComment extends StatelessWidget {
  const AdaComment({super.key});

  static const _startOpacity = 0.0;
  static const _endOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoolCubit, bool>(
      builder: (context, isAnimationComplete) => AnimatedOpacity(
        opacity: switch (isAnimationComplete) {
          false => _startOpacity,
          true => _endOpacity,
        },
        curve: Sizes.adaAnimationCurve,
        duration: Sizes.adaAnimationDuration,
        child: BlocBuilder<AdaAudioBloc, AdaAudioState>(
          builder: (context, state) => switch (state) {
            AdaAudioLoadOnSuccess(:final text) => _Body(text),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.text);

  final String text;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _updateWidgetSize();
  }

  @override
  void didUpdateWidget(covariant _Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _updateWidgetSize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      width: context.screenSize.width * 0.9,
      child: Material(
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.8),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _updateWidgetSize() => WidgetsBinding.instance.addPostFrameCallback((_) {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      context.read<DoubleCubit>().update(renderBox.size.height);
    }
  });
}
