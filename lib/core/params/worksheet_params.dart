import 'dart:typed_data';

class WorksheetParams {
  int? id;
  String? uniqueId;
  int? categoryId;
  Uint8List? content;
  String? name;
  int? worksheetType;
  int? date;

  WorksheetParams({
    this.id,
    this.uniqueId,
    this.categoryId,
    this.content,
    this.name,
    this.worksheetType,
    this.date,
  });
}
