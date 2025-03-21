import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key/menu_anchor.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';
import 'package:gift_keys/ui/pages/key/rive.dart';
import 'package:go_router/go_router.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({required this.giftKey, super.key});

  final GiftKey giftKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final primaryColor = context.colorScheme.primary;

    return MultiBlocListener(
      listeners: [
        BlocListener<KeyMetasBloc, KeyMetasState>(
          listener: _onKeyMetasStateChanged,
        ),
        BlocListener<KeyBloc, KeyState>(listener: _onKeyStateChanged),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => context.pop()),
          title: Text(_translations.appBar),
          actions: [KeyMenuAnchor(id: giftKey.id)],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Align(alignment: Alignment.topRight, child: KeyNfcStatus()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                    vertical: Sizes.verticalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: RiveKey(
                          aid: giftKey.aid,
                          password: giftKey.password,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        giftKey.name,
                        style: textTheme.displayLarge?.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        giftKey.birthday.format(DateTimeFormat.normal),
                        style: textTheme.displaySmall?.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onKeyMetasStateChanged(BuildContext context, KeyMetasState state) =>
      switch (state) {
        KeyMetasUpdateOnSuccess() => context.read<KeyBloc>().add(
          const KeyInitializeEvent(),
        ),
        KeyMetasLoadInProgress() || KeyMetasLoadOnSuccess() => null,
      };

  void _onKeyStateChanged(
    BuildContext context,
    KeyState state,
  ) => switch (state) {
    KeyLoadInProgress() => null,
    KeyLoadOnSuccess(giftKey: GiftKey(:final aid, :final password)) => context
        .read<NfcDiscoveryBloc>()
        .add(NfcDiscoveryInitializeEvent(aid: aid, password: password)),
  };

  static TranslationsPagesKeyEn get _translations =>
      Injector.instance.translations.pages.key;
}
