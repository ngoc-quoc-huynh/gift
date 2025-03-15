import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/static/resources/assets.dart';
import 'package:rive/rive.dart';

class RiveKey extends StatefulWidget {
  const RiveKey({required this.aid, required this.password, super.key});

  final String aid;
  final String password;

  @override
  State<RiveKey> createState() => _RiveKeyState();
}

class _RiveKeyState extends State<RiveKey> {
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
    return BlocProvider<NfcDiscoveryBloc>(
      create:
          (_) =>
              NfcDiscoveryBloc(aid: widget.aid, password: widget.password)
                ..add(const NfcDiscoveryInitializeEvent()),
      child: AspectRatio(
        aspectRatio: 1,
        child: BlocListener<NfcDiscoveryBloc, bool?>(
          listener: _onNfcDiscoveryStateChanged,
          child: RiveAnimation.asset(
            Assets.key(),
            fit: BoxFit.contain,
            artboard: 'Key',
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
    _isCorrect = _controller.getBoolInput('Is key correct')!;
    _isWrong = _controller.getBoolInput('Is key wrong')!;
    artboard.addController(_controller);
  }

  void _onRiveEvent(RiveEvent event) => switch (event.name) {
    'Animation end event' => null,
    _ => null,
  };

  void _onNfcDiscoveryStateChanged(BuildContext _, bool? state) =>
      switch (state) {
        null => null,
        true => _isCorrect.change(true),
        false => _isWrong.change(true),
      };
}
