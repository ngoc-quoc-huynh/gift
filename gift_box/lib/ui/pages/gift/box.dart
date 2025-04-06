import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/gift_box/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/config.dart';
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
      child: BlocProvider<GiftBoxBloc>(
        create:
            (_) => GiftBoxBloc(
              aid: Injector.instance.aid,
              pin: Injector.instance.pin,
            )..add(const GiftBoxInitializeEvent()),
        child: BlocListener<GiftBoxBloc, GiftBoxState>(
          listener: _onGiftBoxStateChanged,
          child: RiveAnimation.asset(
            Assets.gift(),
            fit: BoxFit.contain,
            artboard: 'Gift',
            stateMachines: const ['State Machine'],
            onInit: _onInit,
          ),
        ),
      ),
    );
  }

  void _onInit(Artboard artboard) {
    _controller =
        StateMachineController.fromArtboard(artboard, 'State Machine')!
          ..addEventListener(_onRiveEvent);
    _controller
        .getNumberInput('Skin number')!
        .change(Config.skin.index.toDouble());
    _isCorrect = _controller.getBoolInput('Is key correct')!;
    _isWrong = _controller.getBoolInput('Is key wrong')!;
    artboard.addController(_controller);
  }

  void _onGiftBoxStateChanged(BuildContext _, GiftBoxState state) =>
      switch (state) {
        GiftBoxIdle() => null,
        GiftBoxOpenOnSuccess() => _isCorrect.change(true),
        GiftBoxOpenOnFailure() => _isWrong.change(true),
      };

  void _onRiveEvent(RiveEvent event) => switch (event.name) {
    'Animation end event' => context.read<BoolCubit>().update(true),
    _ => null,
  };
}
