import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/key_meta.dart' as domain;
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key_meta.dart';

void main() {
  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        GiftKeyMeta.fromJson(const {
          'id': 1,
          'name': 'Name',
          'birthday': '2025-01-01',
        }),
        GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime(2025)),
      ),
    );

    test(
      'throws ArgumentError if json is invalid.',
      () => expect(
        () => GiftKeyMeta.fromJson(const {}),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Invalid json structure for GiftKeyMeta.',
          ),
        ),
      ),
    );
  });

  group('toDomain', () {
    test(
      'returns correctly.',
      () => expect(
        GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime(2025)).toDomain(),
        domain.GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime(2025)),
      ),
    );
  });
}
