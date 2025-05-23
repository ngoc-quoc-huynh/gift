import 'package:flutter/material.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/static/resources/assets.dart';
import 'package:gift_box/static/resources/colors.dart';
import 'package:gift_box/ui/router/routes.dart';
import 'package:gift_box/ui/widgets/rive_player.dart';
import 'package:rive_native/rive_native.dart';

class AwesomeSinkPage extends StatefulWidget {
  const AwesomeSinkPage({super.key});

  @override
  State<AwesomeSinkPage> createState() => _AwesomeSinkPageState();
}

class _AwesomeSinkPageState extends State<AwesomeSinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.grey,
      body: RivePlayer(
        asset: Assets.satisfactory(),
        artboardName: 'Awesome Sink',
        withStateMachine: _onInit,
      ),
    );
  }

  void _onInit(StateMachine stateMachine) =>
      stateMachine.addEventListener(_onRiveEvent);

  void _onRiveEvent(Event event) => switch (event.name) {
    'Coupon generated event' => context.goRoute(Routes.awesomeShop),
    String() => null,
  };
}
