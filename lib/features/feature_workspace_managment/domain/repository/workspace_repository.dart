import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/category_params.dart';
import 'package:mashgh/core/params/delete_wroksheet_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';

abstract class WorkspaceRepository {
  Future<DataState<List<CategoryEntity>>> getAllCategoryFromDB();
  Future<DataState<CategoryEntity>> updateCategoryToDB(
      CategoryParams categoryParams);
  Future<DataState<CategoryEntity>> saveCategoryToDB(
      CategoryParams categoryParams);
  Future<DataState<CategoryEntity>> deleteCategoryById(
      CategoryParams categoryParams);
  Future<DataState<List<WorksheetEntity?>>> getAllWorksheetFromDB(
      WorksheetParams worksheetParams);
  Future<DataState<WorksheetEntity?>> getWorksheetByIdFromDB(
      WorksheetParams worksheetParams);
  Future<DataState<int>> deleteWorksheetById(int worksheetId);
}
