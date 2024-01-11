import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';

abstract class SaveTempDocumentStatus extends Equatable {}

class SaveTempDocumentInitial extends SaveTempDocumentStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class SaveTempDocumentLoading extends SaveTempDocumentStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class SaveTempDocumentCompleted extends SaveTempDocumentStatus {
  final WorksheetEntity worksheetEntity;
  SaveTempDocumentCompleted(this.worksheetEntity);

  @override
  List<Object?> get props => [worksheetEntity];
}

/// error state
class SaveTempDocumentError extends SaveTempDocumentStatus {
  final String? message;
  SaveTempDocumentError(this.message);

  @override
  List<Object?> get props => [message];
}
