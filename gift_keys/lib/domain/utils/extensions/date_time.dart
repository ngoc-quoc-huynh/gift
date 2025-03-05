import 'package:gift_keys/injector.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format() => DateFormat.yMd(
    Injector.instance.translations.$meta.locale.flutterLocale.countryCode,
  ).format(this);
}
