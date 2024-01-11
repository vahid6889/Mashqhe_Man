part of 'document_bloc.dart';

class DocumentState extends Equatable {
  final SaveTempDocumentStatus saveTempDocumentStatus;
  final SaveWorksheetShapesStatus saveWorksheetShapesStatus;
  final DeleteAllWorksheetsShapeStatus deleteAllWorksheetsShapeStatus;

  const DocumentState({
    required this.saveTempDocumentStatus,
    required this.saveWorksheetShapesStatus,
    required this.deleteAllWorksheetsShapeStatus,
  });

  DocumentState copyWith({
    SaveTempDocumentStatus? newSaveTempDocumentStatus,
    SaveWorksheetShapesStatus? newSaveWorksheetShapesStatus,
    DeleteAllWorksheetsShapeStatus? newDeleteAllWorksheetsShapeStatus,
  }) {
    return DocumentState(
      saveTempDocumentStatus:
          newSaveTempDocumentStatus ?? saveTempDocumentStatus,
      saveWorksheetShapesStatus:
          newSaveWorksheetShapesStatus ?? saveWorksheetShapesStatus,
      deleteAllWorksheetsShapeStatus:
          newDeleteAllWorksheetsShapeStatus ?? deleteAllWorksheetsShapeStatus,
    );
  }

  @override
  List<Object?> get props => [
        saveTempDocumentStatus,
        saveWorksheetShapesStatus,
        deleteAllWorksheetsShapeStatus,
      ];
}
