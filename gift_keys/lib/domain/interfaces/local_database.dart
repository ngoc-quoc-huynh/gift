import 'package:gift_keys/domain/models/key.dart';

abstract interface class LocalDatabaseApi {
  const LocalDatabaseApi();

  Future<void> initialize();

  Future<GiftKey> saveKey({
    required String imageFileName,
    required String name,
    required DateTime birthday,
    required String aid,
    required String password,
  });

  Future<List<GiftKey>> loadKeys();
}
