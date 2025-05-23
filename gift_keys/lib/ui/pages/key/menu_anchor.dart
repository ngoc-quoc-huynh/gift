import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/key/delete_dialog.dart';
import 'package:gift_keys/ui/router/routes.dart';

class KeyMenuAnchor extends StatelessWidget {
  const KeyMenuAnchor({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (_, controller, child) => IconButton(
        onPressed: () => switch (controller.isOpen) {
          false => controller.open(),
          true => controller.close(),
        },
        icon: child!,
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => context
            ..read<NfcDiscoveryBloc>().add(
              const NfcDiscoveryPauseEvent(),
            )
            ..goRoute(
              Routes.editKeyPage,
              pathParameters: {'id': id.toString()},
            ),
          child: Text(_translations.edit),
        ),
        MenuItemButton(
          onPressed: () => unawaited(KeyDeleteDialog.show(context, id)),
          child: Text(_translations.delete),
        ),
      ],
      child: const Icon(Icons.more_vert_outlined),
    );
  }

  static TranslationsPagesKeyEn get _translations =>
      Injector.instance.translations.pages.key;
}
