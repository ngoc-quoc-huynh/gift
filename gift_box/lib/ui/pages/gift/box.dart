import 'package:flutter/material.dart';
import 'package:gift_box/static/resources/assets.dart';
import 'package:rive/rive.dart';

class GiftBox extends StatefulWidget {
  const GiftBox({super.key});

  @override
  State<GiftBox> createState() => _GiftBoxState();
}

class _GiftBoxState extends State<GiftBox> {
  late StateMachineController _controller;

  late SMIBool _isCorrect;
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
        Assets.gift(),
        fit: BoxFit.contain,
        artboard: 'Gift',
        stateMachines: const ['State Machine'],
        onInit: _onInit,
      ),
    );
  }

  void _onInit(Artboard artboard) {
    _controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine',
    )!
      ..addEventListener(_onEvent);
    _isCorrect = _controller.getBoolInput('Is key correct')!;
    _isWrong = _controller.getBoolInput('Is key wrong')!;
    artboard.addController(_controller);
  }

  void _onEvent(RiveEvent event) {
    if (event.name == 'Animation end event') {
      return;
    }
  }

  // ignore: unused_element, TODO: implement
  void _onCorrectKey() => _isCorrect.change(true);

  // ignore: unused_element, TODO: implement
  void _onWrongKey() => _isWrong.change(true);
}
