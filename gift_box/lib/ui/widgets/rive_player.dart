import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive_native/rive_native.dart';

class RivePlayer extends StatefulWidget {
  const RivePlayer({
    required this.asset,
    this.stateMachineName,
    this.artboardName,
    this.withStateMachine,
    super.key,
  });

  final String asset;
  final String? stateMachineName;
  final String? artboardName;
  final void Function(StateMachine stateMachine)? withStateMachine;

  @override
  State<RivePlayer> createState() => _RivePlayerState();
}

class _RivePlayerState extends State<RivePlayer> {
  File? _riveFile;
  late Artboard _artboard;
  late StateMachinePainter _stateMachinePainter;

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  @override
  void dispose() {
    _artboard.dispose();
    _riveFile?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => switch (_riveFile) {
    null => const SizedBox.shrink(),
    File() => RiveArtboardWidget(
      artboard: _artboard,
      painter: _stateMachinePainter,
    ),
  };

  Future<void> _init() async {
    _riveFile = await _loadFile(context);

    if (context.mounted) {
      setState(() {
        if (_riveFile == null) {
          return;
        }

        _artboard = switch (widget.artboardName) {
          null => _riveFile!.artboardAt(0)!,
          final artboardName => _riveFile!.artboard(artboardName)!,
        };
        _stateMachinePainter = RivePainter.stateMachine(
          stateMachineName: widget.stateMachineName,
          withStateMachine: (stateMachine) {
            widget.withStateMachine?.call(stateMachine);

            final vm = _riveFile!.defaultArtboardViewModel(_artboard);
            if (vm == null) {
              return;
            }
            final vmi = vm.createDefaultInstance();
            if (vmi == null) {
              return;
            }
            stateMachine.bindViewModelInstance(vmi);
          },
        );
      });
    }
  }

  Future<File?> _loadFile(BuildContext context) async {
    final bytes = await DefaultAssetBundle.of(context).load(widget.asset);

    return File.decode(
      bytes.buffer.asUint8List(),
      riveFactory: Factory.flutter,
    );
  }
}
