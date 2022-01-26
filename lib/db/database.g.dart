// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDAO? _noteDAOInstance;

  TagDAO? _tagDAOInstance;

  NoteTagDAO? _noteTagDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `created_at` INTEGER NOT NULL, `updated_at` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Tag` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteTag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `note_id` INTEGER NOT NULL, `tag_id` INTEGER NOT NULL, FOREIGN KEY (`note_id`) REFERENCES `Note` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`tag_id`) REFERENCES `Tag` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDAO get noteDAO {
    return _noteDAOInstance ??= _$NoteDAO(database, changeListener);
  }

  @override
  TagDAO get tagDAO {
    return _tagDAOInstance ??= _$TagDAO(database, changeListener);
  }

  @override
  NoteTagDAO get noteTagDAO {
    return _noteTagDAOInstance ??= _$NoteTagDAO(database, changeListener);
  }
}

class _$NoteDAO extends NoteDAO {
  _$NoteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'updated_at': _dateTimeConverter.encode(item.updatedAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  @override
  Future<List<Note>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM Note',
        mapper: (Map<String, Object?> row) => Note(
            row['id'] as int,
            row['title'] as String,
            row['content'] as String,
            _dateTimeConverter.decode(row['created_at'] as int),
            _dateTimeConverter.decode(row['updated_at'] as int)));
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }
}

class _$TagDAO extends TagDAO {
  _$TagDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<Tag?> getAllTagsAsStream() {
    return _queryAdapter.queryStream('SELECT * FROM Tag',
        mapper: (Map<String, Object?> row) =>
            Tag(row['id'] as int, row['name'] as String),
        queryableName: 'Tag',
        isView: false);
  }
}

class _$NoteTagDAO extends NoteTagDAO {
  _$NoteTagDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<NoteTag>> getTagsForNote(int noteId) async {
    return _queryAdapter.queryList('SELECT * FROM NoteTag WHERE note_id = ?1',
        mapper: (Map<String, Object?> row) => NoteTag(
            row['note_id'] as int, row['tag_id'] as int, row['id'] as int),
        arguments: [noteId]);
  }

  @override
  Future<List<NoteTag>> getNotesForTag(int tagId) async {
    return _queryAdapter.queryList('SELECT * FROM NoteTag WHERE tag_id= ?1',
        mapper: (Map<String, Object?> row) => NoteTag(
            row['note_id'] as int, row['tag_id'] as int, row['id'] as int),
        arguments: [tagId]);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
