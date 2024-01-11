import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';

@Entity(tableName: 'shapes', foreignKeys: [
  ForeignKey(
    childColumns: ['worksheetUniqueId'],
    parentColumns: ['uniqueId'],
    entity: WorksheetEntity,
    onUpdate: ForeignKeyAction.cascade,
    onDelete: ForeignKeyAction.setNull,
  ),
])
class ShapeEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String? uniqueId;
  @ColumnInfo(name: 'worksheetUniqueId')
  final String? worksheetUniqueId;
  final String? content;
  final String? type;
  final double? xPosition;
  final double? yPosition;

  ShapeEntity({
    this.id,
    this.uniqueId,
    this.worksheetUniqueId,
    this.content,
    this.type,
    this.xPosition,
    this.yPosition,
  });

  @override
  List<Object?> get props => [
        id,
        uniqueId,
        worksheetUniqueId,
        content,
        type,
        xPosition,
        yPosition,
      ];
}
