// import 'package:floor/floor.dart';
// import 'package:mashgh/features/feature_text_worksheet/domain/entities/text_worksheet_entity.dart';

// @dao
// abstract class TextWorksheetDao {
//   @Query('SELECT * FROM TextWorksheetEntity')
//   Future<List<TextWorksheetEntity>> getAllShapes();

//   @Query('SELECT * FROM TextWorksheetEntity WHERE type = :type')
//   Future<List<TextWorksheetEntity>> getAllShapesByType(String type);

//   @Query(
//       'SELECT * FROM TextWorksheetEntity WHERE uniqueIdShape = :uniqueIdShape')
//   Future<TextWorksheetEntity?> findShapeById(String uniqueIdShape);

//   @insert
//   Future<void> insertShape(
//     TextWorksheetEntity textWorksheetEntity,
//   );

//   @update
//   Future<void> updateShape(
//     TextWorksheetEntity textWorksheetEntity,
//   );

//   @Query('DELETE FROM TextWorksheetEntity WHERE uniqueIdShape = :uniqueIdShape')
//   Future<void> deleteShapeById(String uniqueIdShape);
// }
