import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/injector.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(DateTimeFormat format) {
    final languageCode =
        Injector.instance.translations.$meta.locale.flutterLocale.languageCode;

    return switch (format) {
      DateTimeFormat.yMd when languageCode == 'de' => DateFormat(
        'dd.MM.yyyy',
      ).format(this),
      DateTimeFormat.yMd => DateFormat('MM/dd/yyyy').format(this),
      DateTimeFormat.yyyyMMdd => DateFormat('yyyyMMdd').format(this),
      DateTimeFormat.yyyyMMDD => DateFormat('yyyy-MM-dd').format(this),
    };
  }
}
