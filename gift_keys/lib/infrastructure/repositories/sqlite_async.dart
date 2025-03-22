import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart' as domain;
import 'package:gift_keys/domain/models/key_meta.dart' as domain;
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key.dart';
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:path/path.dart';
import 'package:sqlite_async/sqlite3.dart';
import 'package:sqlite_async/sqlite_async.dart';

final class SqliteAsyncRepository with LoggerMixin implements LocalDatabaseApi {
  const SqliteAsyncRepository();

  static final _db = SqliteDatabase(
    path: join(Injector.instance.appDir.path, 'app.db'),
  );

  @override
  Future<void> initialize() async {
    await _db.initialize();
    final migrations =
        SqliteMigrations()
          ..createDatabase = _createDatabaseMigration
          ..add(_createDatabaseMigration);
    await migrations.migrate(_db);
    logInfo('SQLite database initialized.');
  }

  @override
  Future<List<domain.GiftKeyMeta>> loadKeyMetas() async {
    try {
      final result = await _db.getAll('''
SELECT id,
       name,
       birthday
FROM $_tableName
ORDER BY birthday ASC;
    ''');

      final metas =
          result.map((json) => GiftKeyMeta.fromJson(json).toDomain()).toList();
      logInfo('Loaded ${metas.length} key metas.');

      return metas;
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to load key metas.',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  @override
  Future<domain.GiftKey> loadKey(int id) async {
    try {
      final json = await _db.get(
        '''
SELECT id,
       name,
       birthday,
       aid,
       password
FROM $_tableName
WHERE id = ?;
    ''',
        [id],
      );

      final key = GiftKey.fromJson(json).toDomain();
      logInfo('Loaded key: $key');

      return key;
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to load key: $id',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  @override
  Future<domain.GiftKeyMeta> saveKey({
    required String name,
    required DateTime birthday,
    required String aid,
    required String password,
  }) async {
    try {
      final result = await _db.execute(
        '''
INSERT INTO $_tableName (
  name,
  birthday,
  aid,
  password
)
VALUES (?, ?, ?, ?)
RETURNING 
  id,
  name,
  birthday;
''',
        [name, birthday.format(DateTimeFormat.dashSeparated), aid, password],
      );

      final meta = GiftKeyMeta.fromJson(result.first).toDomain();
      logInfo('Saved key meta: $meta');

      return meta;
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to save key meta.',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  @override
  Future<void> deleteKeys() async {
    try {
      await _db.execute('''
  DELETE FROM $_tableName;
  DELETE FROM sqlite_sequence WHERE name = $_tableName;
  ''');

      logInfo('Deleted all keys.');
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to delete all keys.',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  @override
  Future<void> deleteKey(int id) async {
    try {
      await _db.execute(
        '''
  DELETE FROM $_tableName
  WHERE id = ?;
  ''',
        [id],
      );

      logInfo('Deleted key: $id');
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to delete key: $id.',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  @override
  Future<domain.GiftKeyMeta> updateKey({
    required int id,
    required String name,
    required DateTime birthday,
    required String aid,
    required String password,
  }) async {
    try {
      final result = await _db.execute(
        '''
UPDATE $_tableName
SET 
  name = ?,
  birthday = ?,
  aid = ?,
  password = ?
WHERE id = ?
RETURNING 
  id,
  name,
  aid,
  birthday;
''',
        [
          name,
          birthday.format(DateTimeFormat.dashSeparated),
          aid,
          password,
          id,
        ],
      );

      final meta = GiftKeyMeta.fromJson(result.first).toDomain();
      logInfo('Updated key meta: $meta');

      return meta;
    } on SqliteException catch (e, stackTrace) {
      logException(
        'Failed to update key meta: $id.',
        exception: e,
        stackTrace: stackTrace,
      );

      throw const LocalDatabaseException();
    }
  }

  static const _tableName = 'key';
  static final _createDatabaseMigration = SqliteMigration(
    1,
    (tx) => tx.execute(_createTable),
  );
  static const _createTable = '''
CREATE TABLE IF NOT EXISTS $_tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    birthday CHAR(10) NOT NULL,
    aid VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);
''';
}
