import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/keys/bloc.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key/key.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';
import 'package:go_router/go_router.dart';

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
        actions: [
          MenuAnchor(
            builder:
                (_, controller, child) => IconButton(
                  onPressed:
                      () => switch (controller.isOpen) {
                        false => controller.open(),
                        true => controller.close(),
                      },
                  icon: child!,
                ),
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  return;
                },
                child: Text(_translations.edit),
              ),
              MenuItemButton(
                onPressed:
                    () =>
                        context
                          ..read<KeysBloc>().add(KeysDeleteEvent(id))
                          ..pop(),
                child: Text(_translations.delete),
              ),
            ],
            child: const Icon(Icons.more_vert_outlined),
          ),
        ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.horizontalPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: KeyNfcStatus(),
                          ),
                          const Spacer(),
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
                },
          ),
        ),
      ),
    );
  }

  static TranslationsPagesKeyEn get _translations =>
      Injector.instance.translations.pages.key;
}
