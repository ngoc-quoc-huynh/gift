import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key_metas/add_button.dart';
import 'package:gift_keys/ui/pages/key_metas/item.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/loading_indicator.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

class KeyMetasPage extends StatelessWidget {
  const KeyMetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeyMetasBloc, KeyMetasState>(
        builder:
            (context, state) => switch (state) {
              KeyMetasLoadInProgress() => const LoadingIndicator(),
              KeyMetasLoadOnSuccess(metas: final metas) => _Body(metas),
            },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.metas);

  final List<GiftKeyMeta> metas;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController(
      initialItem: switch (widget.metas.isEmpty) {
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
    return BlocListener<KeyMetasBloc, KeyMetasState>(
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

          ...widget.metas.map((meta) => KeysItem(giftKeyMeta: meta)),
        ],
      ),
    );
  }

  void _onKeysStateChanged(BuildContext context, KeyMetasState state) {
    switch (state) {
      case KeyMetasAddOnSuccess(:final index, metas: final metas):
        unawaited(
          Injector.instance.fileApi.precacheImage(context, metas[index].id),
        );
        unawaited(
          _controller.animateTo(
            context.screenSize.width * (state.index + 1),
            duration: Duration(milliseconds: 500 * (state.index + 1)),
            curve: Curves.easeInOut,
          ),
        );
      case KeyMetasDeleteOnSuccess():
        // Prevent delay of showing SnackBar after popping page.
        WidgetsBinding.instance.addPostFrameCallback(
          (_) =>
              CustomSnackBar.showSuccess(context, _translations.deleteSuccess),
        );
      case KeyMetasLoadOnSuccess(metas: final metas)
          when state is! KeyMetasAddOnSuccess:
        unawaited(
          Injector.instance.fileApi.precacheImages(
            context,
            metas.map((meta) => meta.id).toList(),
          ),
        );
      default:
        break;
    }
  }

  static TranslationsPagesKeysEn get _translations =>
      Injector.instance.translations.pages.keys;
}
