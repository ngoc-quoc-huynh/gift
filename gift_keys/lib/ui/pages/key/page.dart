import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key/menu_anchor.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';
import 'package:gift_keys/ui/pages/key/rive.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final primaryColor = context.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(_translations.appBar),
        actions: [KeyMenuAnchor(id: id)],
      ),
      body: SafeArea(
        child: BlocProvider<KeyBloc>(
          create: (_) => KeyBloc(id)..add(const KeyInitializeEvent()),
          child: BlocBuilder<KeyBloc, KeyState>(
            builder:
                (context, state) => switch (state) {
                  KeyLoadInProgress() => const SizedBox.shrink(),
                  KeyLoadOnSuccess(
                    giftKey: GiftKey(
                      :final name,
                      :final birthday,
                      :final aid,
                      :final password,
                    ),
                  ) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Align(
                          alignment: Alignment.topRight,
                          child: KeyNfcStatus(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.horizontalPadding,
                              vertical: Sizes.verticalPadding,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RiveKey(aid: aid, password: password),
                                const SizedBox(height: 20),
                                Text(
                                  name,
                                  style: textTheme.displayLarge?.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  birthday.format(DateTimeFormat.normal),
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
                },
          ),
        ),
      ),
    );
  }

  static TranslationsPagesKeyEn get _translations =>
      Injector.instance.translations.pages.key;
}
