import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/ada_audio/bloc.dart';
import 'package:gift_box/domain/blocs/music_tape/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/ui/widgets/ada/comment.dart';
import 'package:gift_box/ui/widgets/ada/rive.dart';
import 'package:gift_box/ui/widgets/max_width_box.dart';

class AdaOverlay extends StatefulWidget {
  const AdaOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<AdaOverlay> createState() => _AdaOverlayState();
}

class _AdaOverlayState extends State<AdaOverlay> {
  final _controller = OverlayPortalController();

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
      ],
      child: BlocListener<AdaAudioBloc, AdaAudioState>(
        listener: _onAdaAudioStateChanged,
        child: OverlayPortal(
          controller: _controller,
          overlayChildBuilder: (_) => const _Overlay(),
          child: widget.child,
        ),
      ),
    );
  }

  void _onAdaAudioStateChanged(BuildContext context, AdaAudioState state) {
    switch (state) {
      case AdaAudioIdle():
        _controller.hide();
        context
          ..read<BoolCubit>().update(false)
          ..read<MusicTapeBloc>().add(
            const MusicTapeDuckVolumeEvent(isDucked: false),
          );
      case AdaAudioPlaying():
        _controller.show();
        context.read<MusicTapeBloc>().add(
          const MusicTapeDuckVolumeEvent(isDucked: true),
        );
    }
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return MaxWidthBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocListener<BoolCubit, bool>(
            listener: _onBoolCubitStateChanged,
            child: const AdaComment(),
          ),
          const AdaRive(),
        ],
      ),
    );
  }

  void _onBoolCubitStateChanged(
    BuildContext context,
    bool isAnimationComplete,
  ) => switch (isAnimationComplete) {
    false => null,
    true => context.read<AdaAudioBloc>().add(const AdaAudioPlayMainEvent()),
  };
}
