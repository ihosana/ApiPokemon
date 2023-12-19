// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDatabaseHelper {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseHelperBuilder databaseBuilder(String name) =>
      _$DatabaseHelperBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseHelperBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseHelperBuilder(null);
}

class _$DatabaseHelperBuilder {
  _$DatabaseHelperBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DatabaseHelperBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseHelperBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseHelper> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseHelper();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseHelper extends DatabaseHelper {
  _$DatabaseHelper([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `PokemonGo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `nome` TEXT NOT NULL, `altura` TEXT NOT NULL, `peso` TEXT NOT NULL, `forca` INTEGER NOT NULL, `isCadastrado` INTEGER NOT NULL, `imageUrl` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonGoInsertionAdapter = InsertionAdapter(
            database,
            'PokemonGo',
            (PokemonGo item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'altura': item.altura,
                  'peso': item.peso,
                  'forca': item.forca,
                  'isCadastrado': item.isCadastrado ? 1 : 0,
                  'imageUrl': item.imageUrl
                }),
        _pokemonGoUpdateAdapter = UpdateAdapter(
            database,
            'PokemonGo',
            ['id'],
            (PokemonGo item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'altura': item.altura,
                  'peso': item.peso,
                  'forca': item.forca,
                  'isCadastrado': item.isCadastrado ? 1 : 0,
                  'imageUrl': item.imageUrl
                }),
        _pokemonGoDeletionAdapter = DeletionAdapter(
            database,
            'PokemonGo',
            ['id'],
            (PokemonGo item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'altura': item.altura,
                  'peso': item.peso,
                  'forca': item.forca,
                  'isCadastrado': item.isCadastrado ? 1 : 0,
                  'imageUrl': item.imageUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonGo> _pokemonGoInsertionAdapter;

  final UpdateAdapter<PokemonGo> _pokemonGoUpdateAdapter;

  final DeletionAdapter<PokemonGo> _pokemonGoDeletionAdapter;

  @override
  Future<List<PokemonGo>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM PokemonGo',
        mapper: (Map<String, Object?> row) => PokemonGo(
            row['id'] as int,
            row['nome'] as String,
            row['altura'] as String,
            row['peso'] as String,
            row['forca'] as int,
            (row['isCadastrado'] as int) != 0,
            row['imageUrl'] as String));
  }

  @override
  Future<int> insertPokemon(PokemonGo pokemon) {
    return _pokemonGoInsertionAdapter.insertAndReturnId(
        pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePokemon(PokemonGo pokemon) async {
    await _pokemonGoUpdateAdapter.update(pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(PokemonGo pokemon) async {
    await _pokemonGoDeletionAdapter.delete(pokemon);
  }
}
