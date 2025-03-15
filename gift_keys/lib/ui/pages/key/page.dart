import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/key/key.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(Injector.instance.translations.pages.key.appBar),
      ),
      body: BlocProvider<KeyBloc>(
        create: (_) => KeyBloc(id)..add(const KeyInitializeEvent()),
        child: BlocBuilder<KeyBloc, KeyState>(
          builder:
              (context, state) => switch (state) {
                KeyLoadInProgress() => const SizedBox.shrink(),
                KeyLoadOnSuccess(:final giftKey) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: KeyNfcStatus(),
                      ),
                      const Spacer(),
                      const RiveKey(),
                      const SizedBox(height: 20),
                      Text(
                        giftKey.name,
                        style: textTheme.displayLarge?.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        giftKey.birthday.format(DateTimeFormat.yMd),
                        style: textTheme.displaySmall?.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              },
        ),
      ),
    );
  }
}
