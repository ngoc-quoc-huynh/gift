import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/ui/pages/keys/add_button.dart';

class KeysPage extends StatelessWidget {
  const KeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeysBloc, KeysState>(
        builder:
            (context, state) => CarouselView(
              itemExtent: double.infinity,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(),
              enableSplash: false,
              itemSnapping: true,
              children: [
                const KeyAddButton(),
                if (state case KeysLoadOnSuccess(:final keys))
                  ...keys.map(
                    (key) => Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(key.image, fit: BoxFit.cover),
                        Center(child: Text(key.toString())),
                      ],
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}
