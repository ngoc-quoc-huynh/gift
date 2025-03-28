import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/key.dart' as domain;
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key.dart';

void main() {
  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        GiftKey.fromJson(const {
          'id': 1,
          'name': 'Name',
          'birthday': '2025-01-01',
          'aid': 'F000000001',
          'password': '1234',
        }),
        GiftKey(
          id: 1,
          name: 'Name',
          birthday: DateTime(2025),
          aid: 'F000000001',
          password: '1234',
        ),
      ),
    );

    test(
      'throws ArgumentError if json is invalid.',
      () => expect(
        () => GiftKey.fromJson(const {}),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Invalid json structure for GiftKey.',
          ),
        ),
      ),
    );
  });

  group('toDomain', () {
    test(
      'returns correctly.',
      () => expect(
        GiftKey(
          id: 1,
          name: 'Name',
          birthday: DateTime(2025),
          aid: 'F000000001',
          password: '1234',
        ).toDomain(),
        domain.GiftKey(
          id: 1,
          name: 'Name',
          birthday: DateTime(2025),
          aid: 'F000000001',
          password: '1234',
        ),
      ),
    );
  });
}
