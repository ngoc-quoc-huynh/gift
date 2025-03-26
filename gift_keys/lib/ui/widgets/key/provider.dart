import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/error_text.dart';

class KeyPageProvider extends StatelessWidget {
  const KeyPageProvider({required this.id, required this.child, super.key});

  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KeyBloc>(
      create: (_) => KeyBloc(id)..add(const KeyInitializeEvent()),
      child: BlocBuilder<KeyBloc, KeyState>(
        builder:
            (context, state) => switch (state) {
              KeyLoadInProgress() => const Scaffold(),
              KeyLoadOnSuccess(:final giftKey) =>
                BlocProvider<NfcDiscoveryBloc>(
                  create:
                      (_) =>
                          NfcDiscoveryBloc()..add(
                            NfcDiscoveryInitializeEvent(
                              aid: giftKey.aid,
                              password: giftKey.password,
                            ),
                          ),
                  child: child,
                ),
              KeyLoadOnFailure() => Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                  ),
                  child: ErrorText(
                    text: Injector.instance.translations.general.error,
                  ),
                ),
              ),
            },
      ),
    );
  }
}
