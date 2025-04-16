import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/utils/form_validators.dart';
import 'package:gift_keys/injector.dart';

void main() {
  final translations = AppLocale.en.buildSync();
  final formTranslations = translations.widgets.form;

  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(translations),
  );

  tearDownAll(Injector.instance.reset);

  group('validateAid', () {
    test('returns validation empty correctly.', () {
      expect(
        FormValidators.validateAid(null),
        formTranslations.aid.validation.empty,
      );
      expect(
        FormValidators.validateAid(''),
        formTranslations.aid.validation.empty,
      );
    });

    test(
      'returns validation hex correctly.',
      () => expect(
        FormValidators.validateAid('z'),
        formTranslations.aid.validation.hex,
      ),
    );

    test('returns validation length correctly.', () {
      expect(
        FormValidators.validateAid('0'),
        formTranslations.aid.validation.length,
      );
      expect(
        FormValidators.validateAid('0' * 33),
        formTranslations.aid.validation.length,
      );
    });

    test('returns null correctly.', () {
      expect(FormValidators.validateAid('0123456789' * 2), isNull);
      expect(FormValidators.validateAid('abcdef' * 2), isNull);
      expect(FormValidators.validateAid('ABCDEF' * 2), isNull);
      expect(FormValidators.validateAid('0123456789abcdef'), isNull);
      expect(FormValidators.validateAid('0123456789ABCDEF'), isNull);
    });
  });

  group('validateBirthday', () {
    test(
      'returns validation empty correctly.',
      () => expect(
        FormValidators.validateBirthday(null),
        formTranslations.birthday.validation,
      ),
    );

    test(
      'returns null correctly.',
      () => expect(FormValidators.validateBirthday(DateTime(2025)), isNull),
    );
  });

  group('validateName', () {
    test('returns validation empty correctly.', () {
      expect(
        FormValidators.validateName(null),
        formTranslations.name.validation,
      );
      expect(FormValidators.validateName(''), formTranslations.name.validation);
    });

    test(
      'returns null correctly.',
      () => expect(FormValidators.validateName('Name'), isNull),
    );
  });

  group('validatePassword', () {
    test('returns validation empty correctly.', () {
      expect(
        FormValidators.validatePassword(null),
        formTranslations.password.validation.empty,
      );
      expect(
        FormValidators.validatePassword(''),
        formTranslations.password.validation.empty,
      );
    });

    test(
      'returns validation length correctly.',
      () => expect(
        FormValidators.validatePassword('123'),
        formTranslations.password.validation.length,
      ),
    );

    test(
      'returns null correctly.',
      () => expect(FormValidators.validatePassword('1234'), isNull),
    );
  });
}
