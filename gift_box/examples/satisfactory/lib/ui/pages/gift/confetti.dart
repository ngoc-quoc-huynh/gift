import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/domain/utils/extensions/build_context.dart';

class GiftConfetti extends StatefulWidget {
  const GiftConfetti({required this.child, super.key});

  final Widget child;

  @override
  State<GiftConfetti> createState() => _GiftConfettiState();
}

class _GiftConfettiState extends State<GiftConfetti> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 10))
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (minimumSize, maximumSize) = switch (context.screenSize.width) {
      < 600 => (const Size(20, 10), const Size(30, 15)),
      _ => (const Size(60, 30), const Size(90, 45)),
    };
    final primaryColor = context.colorScheme.primary;

    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      emissionFrequency: 0.05,
      numberOfParticles: 20,
      minimumSize: minimumSize,
      maximumSize: maximumSize,
      shouldLoop: true,
      colors: Colors.primaries
          .map((color) => color.harmonizeWith(primaryColor))
          .toList(growable: false),
      createParticlePath: _drawStar,
      child: widget.child,
    );
  }

  Path _drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path
        ..lineTo(
          halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step),
        )
        ..lineTo(
          halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep),
        );
    }
    path.close();
    return path;
  }
}
