import 'package:gift_keys/domain/models/add_key.dart';
import 'package:gift_keys/domain/models/key.dart';

abstract interface class LocalDatabaseApi {
  const LocalDatabaseApi();

  Future<void> initialize();

  Future<GiftKey> saveKey(AddGiftKey key);

  Future<List<GiftKey>> loadKeys();
}
