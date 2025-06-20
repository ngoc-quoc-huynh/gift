import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/ui/widgets/ada/comment.dart';
import 'package:gift_box/ui/widgets/ada/rive.dart';

class Ada extends StatelessWidget {
  const Ada({required this.comment, super.key});
  final String comment;

  static void show(BuildContext context, String comment) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Ada(
        comment: comment,
      ),
    );
    overlay.insert(entry);
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
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AdaComment(comment: comment),
          const AdaRive(),
        ],
      ),
    );
  }
}
