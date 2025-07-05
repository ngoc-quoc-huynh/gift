import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key_metas/add_button.dart';
import 'package:gift_keys/ui/pages/key_metas/error.dart';
import 'package:gift_keys/ui/pages/key_metas/item/item.dart';
import 'package:gift_keys/ui/pages/key_metas/settings_button.dart';
import 'package:gift_keys/ui/widgets/loading_indicator.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

class KeyMetasPage extends StatelessWidget {
  const KeyMetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KeyMetasBloc, KeyMetasState>(
        builder: (context, state) => switch (state) {
          KeyMetasLoadInProgress() => const LoadingIndicator(),
          KeyMetasOperationState(:final metas) => _Body(metas),
          KeyMetasLoadOnFailure() => const KeyMetasErrorView(),
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _onKeysStateChanged(context, context.read<KeyMetasBloc>().state),
    );
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
          const SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                  ),
                  child: KeyMetaAddButton(),
                ),
                KeyMetasSettingsButton(),
              ],
            ),
          ),

          ...widget.metas.map((meta) => KeyMetaItem(meta: meta)),
        ],
      ),
    );
  }

  void _onKeysStateChanged(BuildContext context, KeyMetasState state) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          switch (state) {
            case KeyMetasAddOnSuccess(:final index, :final metas):
              unawaited(_precacheImage(context, metas[index].id));
              unawaited(
                _controller.animateToItem(
                  index + 1,
                  duration: Duration(milliseconds: 500 * (index + 1)),
                  curve: Curves.easeInOut,
                ),
              );
            case KeyMetasUpdateOnSuccess(:final index):
              unawaited(
                _controller.animateToItem(
                  index + 1,
                  duration: Duration(milliseconds: 500 * (index + 1)),
                  curve: Curves.easeInOut,
                ),
              );
            case KeyMetasDeleteOnSuccess():
              // Prevent delay of showing SnackBar after popping page.
              CustomSnackBar.showSuccess(
                context,
                _translations.deleteSuccess,
              );
            case KeyMetasLoadOnSuccess(:final metas)
                when state is! KeyMetasAddOnSuccess:
              for (final meta in metas) {
                unawaited(_precacheImage(context, meta.id));
              }
            default:
              break;
          }
        },
      );

  Future<void> _precacheImage(BuildContext context, int id) {
    final file = Injector.instance.fileApi.loadImage(id);
    return Injector.instance.nativeApi.precacheImage(context, file);
  }

  static TranslationsPagesKeysEn get _translations =>
      Injector.instance.translations.pages.keys;
}
