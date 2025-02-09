import 'package:gift_box/injector.dart';

extension ListExtension<T> on List<T> {
  void shuffleSeeded() => shuffle(Injector.instance.random);
}
