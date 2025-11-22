import 'package:gift_box_satisfactory/injector.dart';

extension ListExtension<T> on List<T> {
  void shuffleSeeded() => shuffle(Injector.instance.random);
}
