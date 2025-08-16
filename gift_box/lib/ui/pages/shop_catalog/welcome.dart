import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/colors.dart';

class WelcomeOverlay extends StatefulWidget {
  const WelcomeOverlay({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<WelcomeOverlay> createState() => _WelcomeOverlayState();
}

class _WelcomeOverlayState extends State<WelcomeOverlay> {
  final _controller = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    if (!context.read<BoolCubit>().state) {
      _controller.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (_) => _Overlay(
        _onWelcomeAnimationEnd,
      ),
      child: widget.child,
    );
  }

  void _onWelcomeAnimationEnd() {
    _controller.hide();
    context.read<BoolCubit>().update(true);
  }
}

class _Overlay extends StatefulWidget {
  const _Overlay(this.onAnimationEnd);

  final VoidCallback onAnimationEnd;

  @override
  State<_Overlay> createState() => _OverlayState();
}

class _OverlayState extends State<_Overlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _boxScaleAnimation;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _boxScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0, end: 1),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween(1),
        weight: 3,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1, end: 0),
        weight: 1,
      ),
    ]).animate(_controller);
    _textOpacity =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(begin: 0, end: 1),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: ConstantTween(1),
            weight: 3,
          ),
          TweenSequenceItem(
            tween: Tween(begin: 1, end: 0),
            weight: 1,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.8),
          ),
        );
    _controller
      // ignore: discarded_futures, we don't need to await the animation.
      ..forward()
      ..addStatusListener(_onStatusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizeTransition(
        sizeFactor: _boxScaleAnimation,
        child: SizedBox(
          height: 80,
          child: ColoredBox(
            color: CustomColors.darkGrey,
            child: Center(
              child: FadeTransition(
                opacity: _textOpacity,
                child: Text.rich(
                  _translations.welcomeBack(
                    name: TextSpan(
                      text: _translations.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: CustomColors.orange,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status.isCompleted) {
      widget.onAnimationEnd.call();
    }
  }

  static TranslationsPagesShopCatalogEn get _translations =>
      Injector.instance.translations.pages.shopCatalog;
}
