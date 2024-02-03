// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class CategoryEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String? name;
  final String? nameFa;
  final int? color;
  final int? icon;
  final int? worksheetsCount;

  CategoryEntity({
    this.id,
    this.name,
    this.nameFa,
    this.color,
    this.icon,
    this.worksheetsCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameFa,
        color,
        icon,
        worksheetsCount,
      ];
}
