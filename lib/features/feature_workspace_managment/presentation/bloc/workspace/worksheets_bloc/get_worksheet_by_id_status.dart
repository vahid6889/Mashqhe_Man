import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/usecase/use_case.dart';

abstract class GetWorksheetByIdStatus extends Equatable {}

class GetWorksheetByIdInitial extends GetWorksheetByIdStatus {
  @override
  List<Object?> get props => [NoParams()];
}

/// loading state
class GetWorksheetByIdLoading extends GetWorksheetByIdStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class GetWorksheetByIdCompleted extends GetWorksheetByIdStatus {
  final WorksheetEntity? worksheetEntity;
  GetWorksheetByIdCompleted(this.worksheetEntity);

  @override
  List<Object?> get props => [worksheetEntity];
}

/// error state
class GetWorksheetByIdError extends GetWorksheetByIdStatus {
  final String? message;
  GetWorksheetByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
