import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/ui/pages/gift/box.dart';
import 'package:gift_box/ui/pages/gift/confetti.dart';
import 'package:gift_box/ui/pages/gift/nfc_status.dart';
import 'package:gift_box/ui/router/routes.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: GiftNfcStatus(),
              ),
            ),
          ),
          GiftConfetti(
            child: BlocProvider<BoolCubit>(
              create: (_) => BoolCubit(false),
              child: BlocBuilder<BoolCubit, bool>(
                builder:
                    (context, isOpen) => GestureDetector(
                      onTap: switch (isOpen) {
                        false => null,
                        true => () => context.goRoute(Routes.homePage),
                      },
                      child: const GiftBox(),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
