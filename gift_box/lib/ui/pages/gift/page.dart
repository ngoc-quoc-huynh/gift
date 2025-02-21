import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/ui/pages/gift/box.dart';
import 'package:gift_box/ui/pages/gift/confetti.dart';
import 'package:gift_box/ui/pages/gift/header.dart';
import 'package:gift_box/ui/router/routes.dart';
import 'package:go_router/go_router.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GiftConfetti(
        child: BlocProvider<BoolCubit>(
          create: (_) => BoolCubit(false),
          child: BlocBuilder<BoolCubit, bool>(
            builder: (context, isOpen) => GestureDetector(
              onTap: switch (isOpen) {
                false => null,
                true => () => context.goNamed(Routes.homePage()),
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GiftHeader(),
                  GiftBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
