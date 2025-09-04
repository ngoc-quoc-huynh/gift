import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/pages/gift/box.dart';
import 'package:gift_box/ui/pages/gift/confetti.dart';
import 'package:gift_box/ui/pages/gift/nfc_status.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GiftConfetti(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                    vertical: Sizes.verticalPadding,
                  ),
                  child: GiftNfcStatus(),
                ),
              ),
              Expanded(
                child: BlocProvider<BoolCubit>(
                  create: (_) => BoolCubit(false),
                  child: BlocBuilder<BoolCubit, bool>(
                    builder: (context, isOpen) => GestureDetector(
                      onTap: switch (isOpen) {
                        false => null,
                        true => () => context.goRoute(AppRoute.sink),
                      },
                      child: const GiftBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
