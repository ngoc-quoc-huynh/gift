import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys/bloc.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/keys/add_button.dart';
import 'package:gift_keys/ui/pages/keys/item.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/loading_indicator.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

class KeysPage extends StatelessWidget {
  const KeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeysBloc, KeysState>(
        builder:
            (context, state) => switch (state) {
              KeysLoadInProgress() => const LoadingIndicator(),
              KeysLoadOnSuccess(:final keys) => _Body(keys),
            },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.keys);

  final List<GiftKey> keys;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController(
      initialItem: switch (widget.keys.isEmpty) {
        true => 0,
        false => 1,
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KeysBloc, KeysState>(
      listener: _onKeysStateChanged,
      child: CarouselView(
        controller: _controller,
        itemExtent: double.infinity,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        enableSplash: false,
        itemSnapping: true,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.horizontalPadding,
              ),
              child: Stack(
                children: [
                  const KeyAddButton(),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => context.pushRoute(Routes.settingsPage),
                      tooltip: _translations.settings,
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ...widget.keys.map((key) => KeysItem(giftKey: key)),
        ],
      ),
    );
  }

  void _onKeysStateChanged(BuildContext context, KeysState state) {
    switch (state) {
      case KeysAddOnSuccess(:final index, :final keys):
        unawaited(
          Injector.instance.fileApi.precacheImage(
            context,
            keys[index].imageFileName,
          ),
        );
        unawaited(
          _controller.animateTo(
            context.screenSize.width * (state.index + 1),
            duration: Duration(milliseconds: 500 * (state.index + 1)),
            curve: Curves.easeInOut,
          ),
        );
      case KeysDeleteOnSuccess():
        CustomSnackBar.showSuccess(context, _translations.deleteSuccess);
      case KeysLoadOnSuccess(:final keys) when state is! KeysAddOnSuccess:
        unawaited(
          Injector.instance.fileApi.precacheImages(
            context,
            keys.map((key) => key.imageFileName).toList(),
          ),
        );
      default:
        break;
    }
  }

  static TranslationsPagesKeysEn get _translations =>
      Injector.instance.translations.pages.keys;
}
