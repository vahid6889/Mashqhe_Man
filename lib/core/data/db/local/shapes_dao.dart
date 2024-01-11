import 'package:floor/floor.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

@dao
abstract class ShapesDao {
  @Query('SELECT * FROM shapes')
  Future<List<ShapeEntity>> getAllShapes();

  @Query(
      'SELECT * FROM shapes WHERE type = :type AND worksheetUniqueId = :worksheetUniqueId')
  Future<List<ShapeEntity>> getAllShapesByType(
      String type, String worksheetUniqueId);

  @Query(
      'SELECT * FROM shapes WHERE type = :type AND worksheetUniqueId IS NULL')
  Future<List<ShapeEntity>> getAllShapesWorksheetUniqueIdNullByType(
      String type);

  @Query('SELECT * FROM shapes WHERE uniqueId = :uniqueId')
  Future<ShapeEntity?> findShapeByUniqueId(String uniqueId);

  /// get all shapes worksheet by unique id
  @Query('''
SELECT *
FROM shapes sh
JOIN worksheet w ON sh.worksheetUniqueId = w.id
WHERE w.uniqueId = :uniqueId
''')
  Future<List<ShapeEntity>> getAllShapesWorksheetByUniqueId(String uniqueId);

  /// update all shapes temporary to worksheet id
  @Query('''
UPDATE shapes
SET worksheetUniqueId = :worksheetUniqueId
WHERE worksheetUniqueId IS NULL
''')
  Future<void> updateAllShapesTempToWorksheetUniqueId(String worksheetUniqueId);

  @insert
  Future<void> insertShape(
    ShapeEntity shapeEntity,
  );

  @update
  Future<void> updateShape(
    ShapeEntity shapeEntity,
  );

  @Query('DELETE FROM shapes WHERE uniqueId = :uniqueId')
  Future<void> deleteShapeByUniqueId(String uniqueId);

  @Query('DELETE FROM shapes WHERE worksheetUniqueId = :worksheetUniqueId')
  Future<void> deleteShapeByWorksheetUniqueId(String worksheetUniqueId);

  @Query('DELETE FROM shapes WHERE worksheetUniqueId IS NULL')
  Future<void> deleteAllTempShape();

  /// delete all rows
  @Query('DELETE FROM shapes')
  Future<void> deleteAllShapes();
}
