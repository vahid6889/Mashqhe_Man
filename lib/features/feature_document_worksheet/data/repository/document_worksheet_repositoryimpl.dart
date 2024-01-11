import 'package:mashgh/core/data/db/local/shapes_dao.dart';
import 'package:mashgh/core/data/db/local/worksheet_dao.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/utils/date_converter.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';
import 'package:uuid/uuid.dart';

class DocumentWorksheetRepositoryImpl extends DocumentWorksheetRepository {
  final ShapesDao _shapesDao;
  final WorksheetDao _worksheetDao;
  DocumentWorksheetRepositoryImpl(
    this._shapesDao,
    this._worksheetDao,
  );

  @override
  Future<DataState<List<ShapeEntity>>> getAllShapeByTypeFromDB(
      ShapeParams shapeParams) async {
    try {
      List<ShapeEntity> shapes = shapeParams.worksheetUniqueId != null
          ? await _shapesDao.getAllShapesByType(
              shapeParams.type!,
              shapeParams.worksheetUniqueId!,
            )
          : await _shapesDao
              .getAllShapesWorksheetUniqueIdNullByType(shapeParams.type!);

      return DataSuccess(shapes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<ShapeEntity>> saveShapeToDB(ShapeParams shapeParams) async {
    try {
      /// check shape exist or not
      ShapeEntity? checkShape =
          await _shapesDao.findShapeByUniqueId(shapeParams.uniqueId!);

      if (checkShape == null) {
        ShapeEntity shapeEntityInsert = ShapeEntity(
          uniqueId: shapeParams.uniqueId,
          worksheetUniqueId: shapeParams.worksheetUniqueId,
          content: shapeParams.content,
          type: shapeParams.type,
          xPosition: shapeParams.xPosition,
          yPosition: shapeParams.yPosition,
        );
        await _shapesDao.insertShape(shapeEntityInsert);
        return DataSuccess(shapeEntityInsert);
      } else {
        ShapeEntity shapeEntityInsert = ShapeEntity(
          id: checkShape.id,
          uniqueId: shapeParams.uniqueId,
          worksheetUniqueId: shapeParams.worksheetUniqueId,
          content: shapeParams.content,
          type: shapeParams.type,
          xPosition: shapeParams.xPosition,
          yPosition: shapeParams.yPosition,
        );
        await _shapesDao.updateShape(shapeEntityInsert);
        return DataSuccess(shapeEntityInsert);
      }
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<ShapeEntity>> saveShapesTriggerToDB(
      ShapeParams shapeParams) async {
    try {
      ShapeEntity shapeEntity = ShapeEntity(
        worksheetUniqueId: shapeParams.worksheetUniqueId,
      );

      /// check shape exist or not
      await _shapesDao.updateAllShapesTempToWorksheetUniqueId(
          shapeParams.worksheetUniqueId!);

      return DataSuccess(shapeEntity);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<WorksheetEntity>> saveTempDocumentToDB(
      WorksheetParams worksheetParams) async {
    try {
      /// check temp worksheet exist or not
      List<WorksheetEntity?> checkTempWorksheet =
          await _worksheetDao.getTempWorksheet();

      String uniqueId = const Uuid().v4();

      WorksheetEntity worksheetEntity = WorksheetEntity(
        id: worksheetParams.id ??
            ((checkTempWorksheet.length < 2 || checkTempWorksheet.isEmpty)
                ? null
                : checkTempWorksheet.last!.id),
        uniqueId: worksheetParams.uniqueId ??
            ((checkTempWorksheet.length < 2 || checkTempWorksheet.isEmpty)
                ? uniqueId
                : checkTempWorksheet.last!.uniqueId),
        categoryId: worksheetParams.categoryId,
        content: worksheetParams.content,
        name: worksheetParams.name,
        worksheetType: worksheetParams.worksheetType,
        date:
            worksheetParams.date ?? TimeStampConverter().encode(DateTime.now()),
      );

      (worksheetParams.id != null && worksheetParams.uniqueId != null)
          ? await _worksheetDao.updateWorksheet(worksheetEntity)
          : (checkTempWorksheet.length < 2 || checkTempWorksheet.isEmpty)
              ? await _worksheetDao.insertWorksheet(worksheetEntity)
              : await _worksheetDao.updateWorksheet(worksheetEntity);

      return DataSuccess(worksheetEntity);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<ShapeEntity>> updateShapeContentToDB(
      ShapeParams shapeParams) async {
    try {
      /// update shape to database
      ShapeEntity shapeEntityUpdateContent = ShapeEntity(
        content: shapeParams.content,
        uniqueId: shapeParams.uniqueId,
      );

      await _shapesDao.updateShape(shapeEntityUpdateContent);
      return DataSuccess(shapeEntityUpdateContent);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteShapeByUniqueId(
      ShapeParams shapeParams) async {
    try {
      await _shapesDao.deleteShapeByUniqueId(shapeParams.uniqueId!);
      return DataSuccess(shapeParams.uniqueId!);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteShapeByWorksheetUniqueId(
      ShapeParams shapeParams) async {
    try {
      /// check Worksheet exist or not
      WorksheetEntity? checkExistWorksheet = await _worksheetDao
          .findWorksheetByUniqueId(shapeParams.worksheetUniqueId!);

      if (checkExistWorksheet == null) {
        _shapesDao
            .deleteShapeByWorksheetUniqueId(shapeParams.worksheetUniqueId!);
      }
      return DataSuccess(shapeParams.worksheetUniqueId);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> deleteAllTempShape() async {
    try {
      void deleteAllTempShape = await _shapesDao.deleteAllTempShape();
      return DataSuccess(deleteAllTempShape);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }
}
