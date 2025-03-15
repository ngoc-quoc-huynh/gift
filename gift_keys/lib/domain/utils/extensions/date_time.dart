import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/injector.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(DateTimeFormat format) {
    final languageCode =
        Injector.instance.translations.$meta.locale.flutterLocale.languageCode;
    final pattern = switch (format) {
      DateTimeFormat.compact => 'yyyyMMdd',
      DateTimeFormat.dashSeparated => 'yyyy-MM-dd',
      DateTimeFormat.normal when languageCode == 'de' => 'dd.MM.yyyy',
      DateTimeFormat.normal => 'MM/dd/yyyy',
    };

    return DateFormat(pattern).format(this);
  }
}
