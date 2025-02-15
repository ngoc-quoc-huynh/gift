import 'package:flutter/material.dart';
import 'package:gift_box/ui/pages/timer/countdown.dart';
import 'package:gift_box/ui/pages/timer/image_carousel.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          ImageCarousel(),
          TimerCountdown(),
        ],
      ),
    );
  }
}
