import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/nfc_status/bloc.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/app_lifecycle_observer.dart';

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
              NfcStatusLoadOnSuccess(:final isEnabled) => Tooltip(
                message: Injector.instance.translations.pages.gift.nfcTooltip,
                child: Icon(
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
}
