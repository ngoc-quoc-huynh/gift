import 'package:gift_box/ui/pages/timer/countdown.dart';
import 'package:gift_box/ui/pages/timer/image_carousel.dart';
import 'package:gift_box_satisfactory/ui/pages/timer/countdown.dart';
import 'package:gift_box_satisfactory/ui/pages/timer/image_carousel.dart';
import 'package:material_ui/material_ui.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          TimerImageCarousel(),
          Center(
            child: TimerCountdown(),
          ),
        ],
      ),
    );
  }
}
