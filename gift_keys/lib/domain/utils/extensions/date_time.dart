import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/injector.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(DateTimeFormat format) => switch (format) {
    DateTimeFormat.yMd => DateFormat.yMd(
      Injector.instance.translations.$meta.locale.flutterLocale.countryCode,
    ).format(this),
    DateTimeFormat.yyyyMMdd => DateFormat('yyyyMMdd').format(this),
    DateTimeFormat.yyyyMMDD => DateFormat('yyyy-MM-dd').format(this),
  };
}
