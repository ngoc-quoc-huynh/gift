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
  BooleanInput? _isCorrect;
  BooleanInput? _isWrong;

  @override
  void dispose() {
    _isCorrect?.dispose();
    _isWrong?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NfcDiscoveryBloc, NfcDiscoveryState>(
      listener: _onNfcDiscoveryStateChanged,
      child: RiveWidgetBuilder(
        fileLoader: FileLoader.fromAsset(
          Assets.key(),
          riveFactory: Factory.rive,
        ),
        onLoaded: _onLoaded,
        builder: (context, state) => switch (state) {
          RiveLoaded() => RiveWidget(
            controller: state.controller,
          ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }

  void _onLoaded(RiveLoaded state) {
    final stateMachine = state.controller.stateMachine;
    _isCorrect = stateMachine.boolean('Is key correct');
    _isWrong = stateMachine.boolean('Is key wrong');
    stateMachine.addEventListener(_onRiveEvent);
  }

  void _onRiveEvent(Event event) => switch (event.name) {
    'Animation end event' => null,
    _ => null,
  };

  bool? _onNfcDiscoveryStateChanged(BuildContext _, NfcDiscoveryState state) =>
      switch (state) {
        NfcDiscoveryConnectOnSuccess() => _isCorrect?.value = true,
        NfcDiscoveryConnectOnFailure() => _isWrong?.value = true,
        NfcDiscoveryLoadInProgress() || NfcDiscoveryConnectInProgress() => null,
      };
}
