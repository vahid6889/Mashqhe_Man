import 'dart:async';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:mashgh/core/data/db/local/category_dao.dart';
import 'package:mashgh/core/data/db/local/shapes_dao.dart';
import 'package:mashgh/core/data/db/local/worksheet_dao.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  WorksheetEntity,
  ShapeEntity,
  CategoryEntity,
  // TemporaryWorksheetEntity,
])
abstract class AppDatabase extends FloorDatabase {
  WorksheetDao get worksheetDao;
  ShapesDao get shapesDao;
  CategoryDao get categoryDao;
  // TemporaryWorksheetDao get temporaryWorksheetDao;
}
