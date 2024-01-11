import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';

abstract class DocumentWorksheetRepository {
  Future<DataState<List<ShapeEntity>>> getAllShapeByTypeFromDB(
      ShapeParams shapeParams);
  Future<DataState<ShapeEntity>> saveShapeToDB(ShapeParams shapeParams);
  Future<DataState<ShapeEntity>> saveShapesTriggerToDB(ShapeParams shapeParams);
  Future<DataState<ShapeEntity>> updateShapeContentToDB(
      ShapeParams shapeParams);
  Future<DataState<String>> deleteShapeByUniqueId(ShapeParams shapeParams);
  Future<DataState<String>> deleteShapeByWorksheetUniqueId(
      ShapeParams shapeParams);
  Future<DataState<void>> deleteAllTempShape();
  Future<DataState<WorksheetEntity>> saveTempDocumentToDB(
      WorksheetParams worksheetParams);
}
