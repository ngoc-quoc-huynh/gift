import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/ui/pages/keys/add_button.dart';
import 'package:gift_keys/ui/pages/keys/item.dart';

class KeysPage extends StatefulWidget {
  const KeysPage({super.key});

  @override
  State<KeysPage> createState() => _KeysPageState();
}

class _KeysPageState extends State<KeysPage> {
  final _controller = CarouselController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeysBloc, KeysState>(
        builder:
            (context, state) => CarouselView(
              controller: _controller,
              itemExtent: double.infinity,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(),
              enableSplash: false,
              itemSnapping: true,
              children: [
                BlocListener<KeysBloc, KeysState>(
                  listener: _onKeysStateChanged,
                  child: const KeyAddButton(),
                ),

                if (state case KeysLoadOnSuccess(:final keys))
                  ...keys.map((key) => KeysItem(giftKey: key)),
              ],
            ),
      ),
    );
  }

  void _onKeysStateChanged(BuildContext context, KeysState state) {
    if (state is KeysAddOnSuccess) {
      unawaited(
        _controller.animateTo(
          MediaQuery.sizeOf(context).width * (state.index + 1),
          duration: Duration(milliseconds: 500 * (state.index + 1)),
          curve: Curves.easeInOut,
        ),
      );
    }
  }
}
