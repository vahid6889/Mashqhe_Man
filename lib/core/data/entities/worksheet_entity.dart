// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

@Entity(tableName: 'worksheet', foreignKeys: [
  ForeignKey(
    childColumns: ['categoryId'],
    parentColumns: ['id'],
    entity: CategoryEntity,
    onUpdate: ForeignKeyAction.cascade,
    onDelete: ForeignKeyAction.setNull,
  ),
])
class WorksheetEntity extends Equatable {
  static int TYPE_WORKSHEET_DOCUMENT = 1;
  static int TYPE_WORKSHEET_IMAGE = 2;

  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'uniqueId')
  final String? uniqueId;

  @ColumnInfo(name: 'categoryId')
  final int? categoryId;
  final String? name;

  /// This field can store both text/html and image data
  final Uint8List? content;

  /// 1 = document, 2 = image
  @ColumnInfo(name: 'worksheetType')
  final int? worksheetType;

  @ColumnInfo(name: 'date')
  final int? date;

  WorksheetEntity({
    this.id,
    this.uniqueId,
    this.categoryId,
    this.content,
    this.name,
    this.worksheetType,
    this.date,
  });

  @override
  List<Object?> get props => [
        id,
        uniqueId,
        categoryId,
        content,
        name,
        worksheetType,
        date,
      ];
}
