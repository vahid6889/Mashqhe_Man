import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mashgh/core/data/db/local/category_dao.dart';
import 'package:mashgh/core/data/db/local/worksheet_dao.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/category_params.dart';
import 'package:mashgh/core/params/delete_wroksheet_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class WorkspaceRepositoryImpl extends WorkspaceRepository {
  final CategoryDao _categoryDao;
  final WorksheetDao _worksheetDao;
  WorkspaceRepositoryImpl(
    this._categoryDao,
    this._worksheetDao,
  );

  @override
  Future<DataState<List<CategoryEntity>>> getAllCategoryFromDB() async {
    try {
      // _worksheetDao.getAllWorksheets().then((value) => print(value));
      // List<int> list = 'test'.codeUnits;
      // Uint8List bytes = Uint8List.fromList(list);
      // // String string = String.fromCharCodes(bytes);
      // WorksheetEntity worksheetEntity = WorksheetEntity(
      //   uniqueId: '5000',
      //   categoryId: 8,
      //   content: bytes,
      //   name: 'کاربرگ ریاضی 1',
      // );
      // _worksheetDao.insertWorksheet(worksheetEntity);

      // CategoryEntity categoryEntity = CategoryEntity(
      //   id: 16,
      //   name: '',
      //   nameFa: 'تست',
      //   color: Colors.pink.value,
      //   icon: Icons.menu_book_rounded.codePoint,
      // );
      // await _categoryDao.updateCategory(categoryEntity);
      // await _worksheetDao.deleteAllWorksheet();
      List<CategoryEntity> categories = await _categoryDao.getAllCategory();
      // print(categories);
      return DataSuccess(categories);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CategoryEntity>> saveCategoryToDB(
      CategoryParams categoryParams) async {
    try {
      CategoryEntity categoryEntity = CategoryEntity(
        name: categoryParams.name,
        nameFa: categoryParams.nameFa,
        color: categoryParams.color,
        icon: categoryParams.icon,
      );
      await _categoryDao.insertCategory(categoryEntity);

      return DataSuccess(categoryEntity);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CategoryEntity>> updateCategoryToDB(
      CategoryParams categoryParams) async {
    try {
      CategoryEntity categoryEntity = CategoryEntity(
        id: categoryParams.id,
        name: categoryParams.name,
        nameFa: categoryParams.nameFa,
        color: categoryParams.color,
        icon: categoryParams.icon,
      );
      await _categoryDao.updateCategory(categoryEntity);

      return DataSuccess(categoryEntity);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<CategoryEntity>> deleteCategoryById(
      CategoryParams categoryParams) async {
    try {
      CategoryEntity categoryEntity = CategoryEntity(
        id: categoryParams.id,
      );
      await _categoryDao.deleteCategoryById(categoryParams.id!);

      return DataSuccess(categoryEntity);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<WorksheetEntity?>>> getAllWorksheetFromDB(
      WorksheetParams worksheetParams) async {
    try {
      List<WorksheetEntity?> worksheets = worksheetParams.categoryId != null
          ? await _worksheetDao
              .getAllWorksheetsByCategoryId(worksheetParams.categoryId!)
          : await _worksheetDao.getTempWorksheet();

      return DataSuccess(worksheets);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<WorksheetEntity?>> getWorksheetByIdFromDB(
      WorksheetParams worksheetParams) async {
    try {
      WorksheetEntity? findWorksheet =
          await _worksheetDao.findWorksheetById(worksheetParams.id!);

      return DataSuccess(findWorksheet);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<int>> deleteWorksheetById(int worksheetId) async {
    try {
      await _worksheetDao.deleteWorksheetById(worksheetId);

      return DataSuccess(worksheetId);
    } catch (e) {
      print(e.toString());
      return DataFailed(e.toString());
    }
  }

  // @override
  // Future<DataState<List<ShapeEntity>>> getAllShapeByTypeFromDB(
  //     ShapeParams shapeParams) async {
  //   try {
  //     List<ShapeEntity> cities =
  //         await _shapesDao.getAllShapesByType(shapeParams.type!);
  //     return DataSuccess(cities);
  //   } catch (e) {
  //     return DataFailed(e.toString());
  //   }
  // }
}
