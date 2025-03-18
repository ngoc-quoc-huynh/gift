import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart' as domain;
import 'package:gift_keys/domain/models/key_meta.dart' as domain;
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key.dart';
import 'package:gift_keys/infrastructure/dtos/sqlite_async/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:path/path.dart';
import 'package:sqlite_async/sqlite_async.dart';

final class SqliteAsyncRepository implements LocalDatabaseApi {
  final _db = SqliteDatabase(
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
  }

  @override
  Future<List<domain.GiftKeyMeta>> loadKeyMetas() async {
    final result = await _db.getAll('''
SELECT id,
       imageFileName,
       name,
       birthday
FROM $_tableName
ORDER BY birthday ASC;
    ''');

    return result.map((json) => GiftKeyMeta.fromJson(json).toDomain()).toList();
  }

  @override
  Future<domain.GiftKey> loadKey(int id) async {
    final json = await _db.get(
      '''
SELECT id,
       imageFileName,
       name,
       birthday,
       aid,
       password
FROM $_tableName
WHERE id = ?;
    ''',
      [id],
    );

    return GiftKey.fromJson(json).toDomain();
  }

  @override
  Future<domain.GiftKeyMeta> saveKey({
    required String imageFileName,
    required String name,
    required DateTime birthday,
    required String aid,
    required String password,
  }) async {
    final result = await _db.execute(
      '''
INSERT INTO $_tableName (
  imageFileName,
  name,
  birthday,
  aid,
  password
)
VALUES (?, ?, ?, ?, ?)
RETURNING 
  id,
  imageFileName,
  name,
  birthday;
''',
      [
        imageFileName,
        name,
        birthday.format(DateTimeFormat.dashSeparated),
        aid,
        password,
      ],
    );

    return GiftKeyMeta.fromJson(result.first).toDomain();
  }

  @override
  Future<void> deleteKeys() => _db.execute('''
DELETE FROM $_tableName;
DELETE FROM sqlite_sequence WHERE name = $_tableName;
''');

  @override
  Future<void> deleteKey(int id) => _db.execute(
    '''
DELETE FROM $_tableName
WHERE id = ?;
''',
    [id],
  );

  static const _tableName = 'key';
  static final _createDatabaseMigration = SqliteMigration(
    1,
    (tx) => tx.execute(_createTable),
  );
  static const _createTable = '''
CREATE TABLE IF NOT EXISTS $_tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    imageFileName VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    birthday CHAR(10) NOT NULL,
    aid VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);
''';
}
