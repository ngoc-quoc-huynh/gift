import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:go_router/go_router.dart';

class KeyMenuAnchor extends StatelessWidget {
  const KeyMenuAnchor({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
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
                    ..read<KeyMetasBloc>().add(KeyMetasDeleteEvent(id))
                    ..pop(),
          child: Text(_translations.delete),
        ),
      ],
      child: const Icon(Icons.more_vert_outlined),
    );
  }

  static TranslationsPagesKeyEn get _translations =>
      Injector.instance.translations.pages.key;
}
