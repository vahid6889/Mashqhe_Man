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

  WorksheetDao? _worksheetDaoInstance;

  ShapesDao? _shapesDaoInstance;

  CategoryDao? _categoryDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `worksheet` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `uniqueId` TEXT UNIQUE, `categoryId` INTEGER, `name` TEXT, `content` BLOB, `worksheetType` INTEGER, `date` INTEGER, FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON UPDATE CASCADE ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shapes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `uniqueId` TEXT, `worksheetUniqueId` TEXT, `content` TEXT, `type` TEXT, `xPosition` REAL, `yPosition` REAL, FOREIGN KEY (`worksheetUniqueId`) REFERENCES `worksheet` (`uniqueId`) ON UPDATE CASCADE ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `nameFa` TEXT, `color` INTEGER, `icon` INTEGER, `worksheetsCount` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorksheetDao get worksheetDao {
    return _worksheetDaoInstance ??= _$WorksheetDao(database, changeListener);
  }

  @override
  ShapesDao get shapesDao {
    return _shapesDaoInstance ??= _$ShapesDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$WorksheetDao extends WorksheetDao {
  _$WorksheetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _worksheetEntityInsertionAdapter = InsertionAdapter(
            database,
            'worksheet',
            (WorksheetEntity item) => <String, Object?>{
                  'id': item.id,
                  'uniqueId': item.uniqueId,
                  'categoryId': item.categoryId,
                  'name': item.name,
                  'content': item.content,
                  'worksheetType': item.worksheetType,
                  'date': item.date
                }),
        _worksheetEntityUpdateAdapter = UpdateAdapter(
            database,
            'worksheet',
            ['id'],
            (WorksheetEntity item) => <String, Object?>{
                  'id': item.id,
                  'uniqueId': item.uniqueId,
                  'categoryId': item.categoryId,
                  'name': item.name,
                  'content': item.content,
                  'worksheetType': item.worksheetType,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WorksheetEntity> _worksheetEntityInsertionAdapter;

  final UpdateAdapter<WorksheetEntity> _worksheetEntityUpdateAdapter;

  @override
  Future<List<WorksheetEntity>> getAllWorksheets() async {
    return _queryAdapter.queryList('SELECT * FROM worksheet',
        mapper: (Map<String, Object?> row) => WorksheetEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            categoryId: row['categoryId'] as int?,
            content: row['content'] as Uint8List?,
            name: row['name'] as String?,
            worksheetType: row['worksheetType'] as int?,
            date: row['date'] as int?));
  }

  @override
  Future<WorksheetEntity?> findWorksheetById(int id) async {
    return _queryAdapter.query('SELECT * FROM worksheet WHERE id = ?1',
        mapper: (Map<String, Object?> row) => WorksheetEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            categoryId: row['categoryId'] as int?,
            content: row['content'] as Uint8List?,
            name: row['name'] as String?,
            worksheetType: row['worksheetType'] as int?,
            date: row['date'] as int?),
        arguments: [id]);
  }

  @override
  Future<WorksheetEntity?> findWorksheetByUniqueId(String uniqueId) async {
    return _queryAdapter.query('SELECT * FROM worksheet WHERE uniqueId = ?1',
        mapper: (Map<String, Object?> row) => WorksheetEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            categoryId: row['categoryId'] as int?,
            content: row['content'] as Uint8List?,
            name: row['name'] as String?,
            worksheetType: row['worksheetType'] as int?,
            date: row['date'] as int?),
        arguments: [uniqueId]);
  }

  @override
  Future<List<WorksheetEntity?>> getTempWorksheet() async {
    return _queryAdapter.queryList(
        'SELECT * FROM worksheet WHERE categoryId IS NULL ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => WorksheetEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            categoryId: row['categoryId'] as int?,
            content: row['content'] as Uint8List?,
            name: row['name'] as String?,
            worksheetType: row['worksheetType'] as int?,
            date: row['date'] as int?));
  }

  @override
  Future<List<WorksheetEntity>> getAllWorksheetsByCategoryId(
      int categoryId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM worksheet WHERE categoryId = ?1 ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => WorksheetEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            categoryId: row['categoryId'] as int?,
            content: row['content'] as Uint8List?,
            name: row['name'] as String?,
            worksheetType: row['worksheetType'] as int?,
            date: row['date'] as int?),
        arguments: [categoryId]);
  }

  @override
  Future<List<WorksheetEntity>> getAllWorksheetsByCategoryName(
      String categoryName) async {
    return _queryAdapter.queryList(
        'SELECT *  FROM worksheet w JOIN category c ON w.categoryId = c.id WHERE c.name = ?1 ORDER BY w.date DESC',
        mapper: (Map<String, Object?> row) => WorksheetEntity(id: row['id'] as int?, uniqueId: row['uniqueId'] as String?, categoryId: row['categoryId'] as int?, content: row['content'] as Uint8List?, name: row['name'] as String?, worksheetType: row['worksheetType'] as int?, date: row['date'] as int?),
        arguments: [categoryName]);
  }

  @override
  Future<void> deleteWorksheetByUniqueId(String uniqueId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM worksheet WHERE uniqueId = ?1',
        arguments: [uniqueId]);
  }

  @override
  Future<void> deleteWorksheetById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM worksheet WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllWorksheet() async {
    await _queryAdapter.queryNoReturn('DELETE FROM worksheet');
  }

  @override
  Future<void> deleteAllWorksheetAndShapesTemporary() async {
    await _queryAdapter.queryNoReturn(
        'DELETE worksheet w ,shapes sh  FROM worksheet  INNER JOIN shapes   WHERE w.id = sh.worksheetUniqueId  AND w.categoryId IS NULL');
  }

  @override
  Future<void> insertWorksheet(WorksheetEntity worksheetEntity) async {
    await _worksheetEntityInsertionAdapter.insert(
        worksheetEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWorksheet(WorksheetEntity worksheetEntity) async {
    await _worksheetEntityUpdateAdapter.update(
        worksheetEntity, OnConflictStrategy.abort);
  }
}

class _$ShapesDao extends ShapesDao {
  _$ShapesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _shapeEntityInsertionAdapter = InsertionAdapter(
            database,
            'shapes',
            (ShapeEntity item) => <String, Object?>{
                  'id': item.id,
                  'uniqueId': item.uniqueId,
                  'worksheetUniqueId': item.worksheetUniqueId,
                  'content': item.content,
                  'type': item.type,
                  'xPosition': item.xPosition,
                  'yPosition': item.yPosition
                }),
        _shapeEntityUpdateAdapter = UpdateAdapter(
            database,
            'shapes',
            ['id'],
            (ShapeEntity item) => <String, Object?>{
                  'id': item.id,
                  'uniqueId': item.uniqueId,
                  'worksheetUniqueId': item.worksheetUniqueId,
                  'content': item.content,
                  'type': item.type,
                  'xPosition': item.xPosition,
                  'yPosition': item.yPosition
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShapeEntity> _shapeEntityInsertionAdapter;

  final UpdateAdapter<ShapeEntity> _shapeEntityUpdateAdapter;

  @override
  Future<List<ShapeEntity>> getAllShapes() async {
    return _queryAdapter.queryList('SELECT * FROM shapes',
        mapper: (Map<String, Object?> row) => ShapeEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            worksheetUniqueId: row['worksheetUniqueId'] as String?,
            content: row['content'] as String?,
            type: row['type'] as String?,
            xPosition: row['xPosition'] as double?,
            yPosition: row['yPosition'] as double?));
  }

  @override
  Future<List<ShapeEntity>> getAllShapesByType(
    String type,
    String worksheetUniqueId,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shapes WHERE type = ?1 AND worksheetUniqueId = ?2',
        mapper: (Map<String, Object?> row) => ShapeEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            worksheetUniqueId: row['worksheetUniqueId'] as String?,
            content: row['content'] as String?,
            type: row['type'] as String?,
            xPosition: row['xPosition'] as double?,
            yPosition: row['yPosition'] as double?),
        arguments: [type, worksheetUniqueId]);
  }

  @override
  Future<List<ShapeEntity>> getAllShapesWorksheetUniqueIdNullByType(
      String type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shapes WHERE type = ?1 AND worksheetUniqueId IS NULL',
        mapper: (Map<String, Object?> row) => ShapeEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            worksheetUniqueId: row['worksheetUniqueId'] as String?,
            content: row['content'] as String?,
            type: row['type'] as String?,
            xPosition: row['xPosition'] as double?,
            yPosition: row['yPosition'] as double?),
        arguments: [type]);
  }

  @override
  Future<ShapeEntity?> findShapeByUniqueId(String uniqueId) async {
    return _queryAdapter.query('SELECT * FROM shapes WHERE uniqueId = ?1',
        mapper: (Map<String, Object?> row) => ShapeEntity(
            id: row['id'] as int?,
            uniqueId: row['uniqueId'] as String?,
            worksheetUniqueId: row['worksheetUniqueId'] as String?,
            content: row['content'] as String?,
            type: row['type'] as String?,
            xPosition: row['xPosition'] as double?,
            yPosition: row['yPosition'] as double?),
        arguments: [uniqueId]);
  }

  @override
  Future<List<ShapeEntity>> getAllShapesWorksheetByUniqueId(
      String uniqueId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shapes sh JOIN worksheet w ON sh.worksheetUniqueId = w.id WHERE w.uniqueId = ?1',
        mapper: (Map<String, Object?> row) => ShapeEntity(id: row['id'] as int?, uniqueId: row['uniqueId'] as String?, worksheetUniqueId: row['worksheetUniqueId'] as String?, content: row['content'] as String?, type: row['type'] as String?, xPosition: row['xPosition'] as double?, yPosition: row['yPosition'] as double?),
        arguments: [uniqueId]);
  }

  @override
  Future<void> updateAllShapesTempToWorksheetUniqueId(
      String worksheetUniqueId) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE shapes SET worksheetUniqueId = ?1 WHERE worksheetUniqueId IS NULL',
        arguments: [worksheetUniqueId]);
  }

  @override
  Future<void> deleteShapeByUniqueId(String uniqueId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM shapes WHERE uniqueId = ?1',
        arguments: [uniqueId]);
  }

  @override
  Future<void> deleteShapeByWorksheetUniqueId(String worksheetUniqueId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM shapes WHERE worksheetUniqueId = ?1',
        arguments: [worksheetUniqueId]);
  }

  @override
  Future<void> deleteAllTempShape() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM shapes WHERE worksheetUniqueId IS NULL');
  }

  @override
  Future<void> deleteAllShapes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM shapes');
  }

  @override
  Future<void> insertShape(ShapeEntity shapeEntity) async {
    await _shapeEntityInsertionAdapter.insert(
        shapeEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateShape(ShapeEntity shapeEntity) async {
    await _shapeEntityUpdateAdapter.update(
        shapeEntity, OnConflictStrategy.abort);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'nameFa': item.nameFa,
                  'color': item.color,
                  'icon': item.icon,
                  'worksheetsCount': item.worksheetsCount
                }),
        _categoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'nameFa': item.nameFa,
                  'color': item.color,
                  'icon': item.icon,
                  'worksheetsCount': item.worksheetsCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  final UpdateAdapter<CategoryEntity> _categoryEntityUpdateAdapter;

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    return _queryAdapter.queryList(
        'SELECT c.id,c.name,c.nameFa,c.color,c.icon,COUNT(w.id) as worksheetsCount FROM category c LEFT JOIN worksheet w on c.id = w.categoryId  GROUP BY c.id',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            nameFa: row['nameFa'] as String?,
            color: row['color'] as int?,
            icon: row['icon'] as int?,
            worksheetsCount: row['worksheetsCount'] as int?));
  }

  @override
  Future<CategoryEntity?> findCategoryByName(String name) async {
    return _queryAdapter.query('SELECT * FROM category WHERE name = ?1',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            nameFa: row['nameFa'] as String?,
            color: row['color'] as int?,
            icon: row['icon'] as int?,
            worksheetsCount: row['worksheetsCount'] as int?),
        arguments: [name]);
  }

  @override
  Future<void> deleteFromWorksheet(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM worksheet WHERE categoryId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteFromCategory(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM category WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllCategory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM category');
  }

  @override
  Future<void> insertCategory(CategoryEntity categoryEntity) async {
    await _categoryEntityInsertionAdapter.insert(
        categoryEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategory(CategoryEntity categoryEntity) async {
    await _categoryEntityUpdateAdapter.update(
        categoryEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategoryById(int id) async {
    if (database is sqflite.Transaction) {
      await super.deleteCategoryById(id);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.categoryDao.deleteCategoryById(id);
      });
    }
  }
}
