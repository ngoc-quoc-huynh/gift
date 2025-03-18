import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/models/key_meta.dart';

abstract interface class LocalDatabaseApi {
  const LocalDatabaseApi();

  Future<void> initialize();

  Future<GiftKeyMeta> saveKey({
    required String name,
    required DateTime birthday,
    required String aid,
    required String password,
  });

  Future<List<GiftKeyMeta>> loadKeyMetas();

  Future<GiftKey> loadKey(int id);

  Future<void> deleteKeys();

  Future<void> deleteKey(int id);
}
