import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/usecase/use_case.dart';

abstract class GetAllWorksheetStatus extends Equatable {}

class GetAllWorksheetInitial extends GetAllWorksheetStatus {
  @override
  List<Object?> get props => [NoParams()];
}

/// loading state
class GetAllWorksheetLoading extends GetAllWorksheetStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class GetAllWorksheetCompleted extends GetAllWorksheetStatus {
  final List<WorksheetEntity?> worksheetEntity;
  GetAllWorksheetCompleted(this.worksheetEntity);

  @override
  List<Object?> get props => [worksheetEntity];
}

/// error state
class GetAllWorksheetError extends GetAllWorksheetStatus {
  final String? message;
  GetAllWorksheetError(this.message);

  @override
  List<Object?> get props => [message];
}
