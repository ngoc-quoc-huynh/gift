import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/models/key.dart';

class KeyPageBuilder extends StatelessWidget {
  const KeyPageBuilder({required this.builder, super.key});

  final Widget Function(GiftKey) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyBloc, KeyState>(
      builder:
          (context, state) => switch (state) {
            KeyLoadInProgress() =>
              throw AssertionError('At this point, the key should be loaded.'),
            KeyLoadOnSuccess(:final giftKey) => builder.call(giftKey),
          },
    );
  }
}
