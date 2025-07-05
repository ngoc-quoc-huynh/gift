import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/ada_audio/bloc.dart';
import 'package:gift_box/domain/blocs/music_tape/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/ui/widgets/ada/comment.dart';
import 'package:gift_box/ui/widgets/ada/rive.dart';

class Ada extends StatelessWidget {
  const Ada({required this.id, required this.entry, super.key});

  final String id;
  final OverlayEntry entry;

  static void show(BuildContext context, String id) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => Ada(id: id, entry: entry),
    );
    overlay.insert(entry);
    context.read<MusicTapeBloc>().add(
      const MusicTapeDuckVolumeEvent(isDucked: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoubleCubit>(
          create: (_) => DoubleCubit(0),
        ),
        BlocProvider<BoolCubit>(
          create: (_) => BoolCubit(false),
        ),
        BlocProvider<AdaAudioBloc>(
          create: (_) => AdaAudioBloc()..add(AdaAudioInitializeEvent(id)),
        ),
      ],
      child: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<BoolCubit, bool>(
                  listener: _onBoolCubitStateChanged,
                ),
                BlocListener<AdaAudioBloc, AdaAudioState>(
                  listener: _onAdaAudioStateChanged,
                ),
              ],
              child: const AdaComment(),
            ),
            const AdaRive(),
          ],
        ),
      ),
    );
  }

  void _onBoolCubitStateChanged(
    BuildContext context,
    bool isAnimationComplete,
  ) => switch (isAnimationComplete) {
    false => null,
    true => context.read<AdaAudioBloc>().add(
      const AdaAudioPlayEvent(),
    ),
  };

  void _onAdaAudioStateChanged(BuildContext context, AdaAudioState state) {
    switch (state) {
      case AdaAudioLoadOnComplete():
        entry.remove();
        context.read<MusicTapeBloc>().add(
          const MusicTapeDuckVolumeEvent(isDucked: false),
        );
      default:
        break;
    }
  }
}
