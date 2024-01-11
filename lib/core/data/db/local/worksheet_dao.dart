import 'package:floor/floor.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';

@dao
abstract class WorksheetDao {
  @Query('SELECT * FROM worksheet')
  Future<List<WorksheetEntity>> getAllWorksheets();

  @Query('SELECT * FROM worksheet WHERE id = :id')
  Future<WorksheetEntity?> findWorksheetById(int id);

  @Query('SELECT * FROM worksheet WHERE uniqueId = :uniqueId')
  Future<WorksheetEntity?> findWorksheetByUniqueId(String uniqueId);

  @Query("SELECT * FROM worksheet WHERE categoryId IS NULL ORDER BY date DESC")
  Future<List<WorksheetEntity?>> getTempWorksheet();

  // get all worksheets by category id
  @Query(
      'SELECT * FROM worksheet WHERE categoryId = :categoryId ORDER BY date DESC')
  Future<List<WorksheetEntity>> getAllWorksheetsByCategoryId(int categoryId);

// get all worksheets by category name
  @Query('''
SELECT * 
FROM worksheet w
JOIN category c ON w.categoryId = c.id
WHERE c.name = :categoryName
ORDER BY w.date DESC
''')
  Future<List<WorksheetEntity>> getAllWorksheetsByCategoryName(
      String categoryName);

  @insert
  Future<void> insertWorksheet(
    WorksheetEntity worksheetEntity,
  );

  @update
  Future<void> updateWorksheet(
    WorksheetEntity worksheetEntity,
  );

  @Query('DELETE FROM worksheet WHERE uniqueId = :uniqueId')
  Future<void> deleteWorksheetByUniqueId(String uniqueId);

  @Query('DELETE FROM worksheet WHERE id = :id')
  Future<void> deleteWorksheetById(int id);

  /// delete all rows
  @Query('DELETE FROM worksheet')
  Future<void> deleteAllWorksheet();

  /// delete all worksheet and shapes temporary
  @Query('''
DELETE worksheet w ,shapes sh 
FROM worksheet 
INNER JOIN shapes  
WHERE w.id = sh.worksheetUniqueId 
AND w.categoryId IS NULL
''')
  Future<void> deleteAllWorksheetAndShapesTemporary();
}
