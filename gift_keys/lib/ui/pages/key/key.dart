import 'package:flutter/material.dart';
import 'package:gift_keys/static/resources/assets.dart';
import 'package:rive/rive.dart';

class RiveKey extends StatefulWidget {
  const RiveKey({super.key});

  @override
  State<RiveKey> createState() => _RiveKeyState();
}

class _RiveKeyState extends State<RiveKey> {
  late StateMachineController _controller;

  // ignore: unused_field, TODO: Add logic
  late SMIBool _isCorrect;

  // ignore: unused_field, TODO: Add logic
  late SMIBool _isWrong;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: RiveAnimation.asset(
        Assets.key(),
        fit: BoxFit.contain,
        artboard: 'Key',
        stateMachines: const ['State Machine'],
        onInit: _onInit,
      ),
    );
  }

  void _onInit(Artboard artboard) {
    _controller =
        StateMachineController.fromArtboard(artboard, 'State Machine')!
          ..addEventListener(_onRiveEvent);
    _isCorrect = _controller.getBoolInput('Is key correct')!;
    _isWrong = _controller.getBoolInput('Is key wrong')!;
    artboard.addController(_controller);
  }

  void _onRiveEvent(RiveEvent event) => switch (event.name) {
    'Animation end event' => null,
    _ => null,
  };
}
