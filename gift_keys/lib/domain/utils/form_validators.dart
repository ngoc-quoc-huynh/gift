import 'package:gift_keys/injector.dart';

final class FormValidators {
  const FormValidators._();

  static String? validateAid(String? val) => switch (val) {
    null => _translations.aid.validation.empty,
    final val when val.isEmpty => _translations.aid.validation.empty,
    String() when !RegExp(r'^[0-9A-Fa-f]+$').hasMatch(val) =>
      _translations.aid.validation.hex,
    String() when val.length < 10 || val.length > 32 =>
      _translations.aid.validation.length,
    String() => null,
  };

  static String? validateBirthday(DateTime? val) => switch (val) {
    null => _translations.birthday.validation,
    DateTime() => null,
  };

  static String? validateName(String? val) =>
      _validateEmpty(val, _translations.name.validation);

  static String? validatePassword(String? val) => switch (val) {
    null => _translations.password.validation.empty,
    final val when val.isEmpty => _translations.password.validation.empty,
    String() when val.length < 4 => _translations.password.validation.length,
    String() => null,
  };

  static String? _validateEmpty(String? val, String message) => switch (val) {
    null => message,
    final val when val.isEmpty => message,
    String() => null,
  };

  static TranslationsWidgetsFormEn get _translations =>
      Injector.instance.translations.widgets.form;
}
