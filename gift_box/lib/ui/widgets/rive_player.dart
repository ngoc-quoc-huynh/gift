import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RivePlayer extends StatelessWidget {
  const RivePlayer({
    required this.asset,
    this.stateMachineName,
    this.artboardName,
    this.onLoaded,
    super.key,
  });

  final String asset;
  final String? stateMachineName;
  final String? artboardName;
  final void Function(StateMachine stateMachine)? onLoaded;

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBuilder(
      artboardSelector: _artboardSelector,
      stateMachineSelector: _stateMachineSelector,
      fileLoader: FileLoader.fromAsset(
        asset,
        riveFactory: Factory.rive,
      ),
      onLoaded: (state) => onLoaded?.call(state.controller.stateMachine),
      builder: (context, state) => switch (state) {
        RiveLoaded() => RiveWidget(
          controller: state.controller,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }

  ArtboardSelector get _artboardSelector => switch (artboardName) {
    null => const ArtboardDefault(),
    final artboardName => ArtboardSelector.byName(artboardName),
  };

  StateMachineSelector get _stateMachineSelector => switch (stateMachineName) {
    null => const StateMachineDefault(),
    final stateMachineName => StateMachineSelector.byName(stateMachineName),
  };
}
