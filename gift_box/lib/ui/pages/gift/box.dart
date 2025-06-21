import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/gift_box/bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/config.dart';
import 'package:gift_box/ui/widgets/rive_player.dart';
import 'package:rive_native/rive_native.dart';

class GiftBox extends StatefulWidget {
  const GiftBox({super.key});

  @override
  State<GiftBox> createState() => _GiftBoxState();
}

class _GiftBoxState extends State<GiftBox> {
  late BooleanInput _isCorrect;
  late BooleanInput _isWrong;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiftBoxBloc>(
      create: (_) => GiftBoxBloc(
        aid: Injector.instance.aid,
        pin: Injector.instance.pin,
      )..add(const GiftBoxInitializeEvent()),
      child: BlocListener<GiftBoxBloc, GiftBoxState>(
        listener: _onGiftBoxStateChanged,
        child: RivePlayer(
          asset: Asset.gift(),
          artboardName: 'Gift',
          withStateMachine: _onInit,
        ),
      ),
    );
  }

  void _onInit(StateMachine stateMachine) {
    _isCorrect = stateMachine.boolean('Is key correct')!;
    _isWrong = stateMachine.boolean('Is key wrong')!;
    stateMachine.number('Skin number')!.value = Config.skin.index.toDouble();
    stateMachine.addEventListener(_onRiveEvent);
  }

  void _onGiftBoxStateChanged(BuildContext _, GiftBoxState state) =>
      switch (state) {
        GiftBoxIdle() => null,
        GiftBoxOpenOnSuccess() => _isCorrect.value = true,
        GiftBoxOpenOnFailure() => _isWrong.value = true,
      };

  void _onRiveEvent(Event event) => switch (event.name) {
    'Animation end event' =>
      context
        ..read<HydratedBoolCubit>().update(true)
        ..goRoute(AppRoute.home),
    _ => null,
  };
}
