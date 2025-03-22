import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';

class KeyMetaImageBackground extends StatefulWidget {
  const KeyMetaImageBackground({
    required this.id,
    required this.child,
    super.key,
  });

  final int id;
  final Widget child;

  @override
  State<KeyMetaImageBackground> createState() => _KeyMetaImageBackgroundState();
}

class _KeyMetaImageBackgroundState extends State<KeyMetaImageBackground> {
  late final FileImage _fileImage = FileImage(
    Injector.instance.fileApi.loadImage(widget.id),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<KeyMetasBloc, KeyMetasState>(
      listener: _onKeyMetasStateChanged,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _fileImage,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(
                alpha: switch (context.theme.brightness) {
                  Brightness.light => 0,
                  Brightness.dark => 0.2,
                },
              ),
              BlendMode.darken,
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }

  void _onKeyMetasStateChanged(BuildContext _, KeyMetasState state) =>
      switch (state) {
        KeyMetasUpdateOnSuccess(:final index, :final metas)
            when metas[index].id == widget.id =>
          unawaited(_fileImage.evict()),
        KeyMetasInitial() || KeyMetasOperationState() => null,
      };
}
