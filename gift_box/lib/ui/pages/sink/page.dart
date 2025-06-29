import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/static/resources/colors.dart';
import 'package:gift_box/ui/widgets/rive_player.dart';
import 'package:rive_native/rive_native.dart';

class SinkPage extends StatefulWidget {
  const SinkPage({super.key});

  @override
  State<SinkPage> createState() => _SinkPageState();
}

class _SinkPageState extends State<SinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.grey,
      body: RivePlayer(
        asset: Asset.satisfactory(),
        artboardName: 'Awesome Sink',
        onLoaded: _onLoaded,
      ),
    );
  }

  void _onLoaded(StateMachine stateMachine) =>
      stateMachine.addEventListener(_onRiveEvent);

  void _onRiveEvent(Event event) => switch (event.name) {
    'Coupon generated event' => context.goRoute(AppRoute.shop),
    String() => null,
  };
}
