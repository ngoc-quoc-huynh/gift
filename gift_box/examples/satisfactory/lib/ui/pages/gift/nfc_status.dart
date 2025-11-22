import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/blocs/nfc_status/bloc.dart';
import 'package:gift_box_satisfactory/domain/utils/extensions/build_context.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:gift_box_satisfactory/ui/widgets/app_lifecycle_observer.dart';
import 'package:gift_box_satisfactory/ui/widgets/snack_bar.dart';

class GiftNfcStatus extends StatelessWidget {
  const GiftNfcStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;

    return BlocProvider<NfcStatusBloc>(
      create: (_) => NfcStatusBloc()..add(const NfcStatusCheckEvent()),
      child: Builder(
        builder: (context) => AppLifecycleObserver(
          onResume: () => context.read<NfcStatusBloc>().add(
            const NfcStatusCheckEvent(),
          ),
          child: BlocBuilder<NfcStatusBloc, NfcStatusState>(
            builder: (context, state) => switch (state) {
              NfcStatusLoadInProgress() => const SizedBox.shrink(),
              NfcStatusLoadOnSuccess(:final isEnabled) => IconButton(
                onPressed: () => _onPressed(context, isEnabled: isEnabled),
                icon: Icon(
                  Icons.nfc,
                  color: switch (isEnabled) {
                    false => Colors.red,
                    true => Colors.green,
                  }.harmonizeWith(primaryColor),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context, {required bool isEnabled}) {
    final message = switch (isEnabled) {
      false => _translations.nfcHintDisabled,
      true => _translations.nfcHintEnabled,
    };

    CustomSnackBar.showInfo(context, message);
  }

  TranslationsPagesGiftEn get _translations =>
      Injector.instance.translations.pages.gift;
}
