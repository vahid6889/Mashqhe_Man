import 'package:equatable/equatable.dart';
import 'package:mashgh/core/usecase/use_case.dart';

abstract class DeleteWorksheetStatus extends Equatable {}

class DeleteWorksheetInitial extends DeleteWorksheetStatus {
  @override
  List<Object?> get props => [NoParams()];
}

/// loading state
class DeleteWorksheetLoading extends DeleteWorksheetStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class DeleteWorksheetCompleted extends DeleteWorksheetStatus {
  final int worksheetId;
  DeleteWorksheetCompleted(this.worksheetId);

  @override
  List<Object?> get props => [worksheetId];
}

/// error state
class DeleteWorksheetError extends DeleteWorksheetStatus {
  final String? message;
  DeleteWorksheetError(this.message);

  @override
  List<Object?> get props => [message];
}
