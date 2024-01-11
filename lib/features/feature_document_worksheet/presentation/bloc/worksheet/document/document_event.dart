part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent {}

class SaveTempDocumentEvent extends DocumentEvent {
  final WorksheetParams worksheetParams;
  SaveTempDocumentEvent(this.worksheetParams);
}

/// saving and update the shapes placed on the worksheet when leaving the worksheet and going to another page
class ShapesSaveTriggerEvent extends DocumentEvent {
  final ShapeParams shapeParams;
  ShapesSaveTriggerEvent(this.shapeParams);
}

/// when the user places shapes on the screen and exits
/// the program without saving the worksheet and re-enters
/// the program and opens a temporary worksheet, all the shapes saved with
/// the worksheet ID are deleted.
class DeleteAllTempShapeEvent extends DocumentEvent {
  final NoParams noParams;
  DeleteAllTempShapeEvent(this.noParams);
}

class DeleteShapesByWorksheetsUniqueIdEvent extends DocumentEvent {
  final ShapeParams shapeParams;
  DeleteShapesByWorksheetsUniqueIdEvent(this.shapeParams);
}
