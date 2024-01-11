import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class SaveCircleWorksheetStatus extends Equatable {}

class SaveCircleWorksheetInitial extends SaveCircleWorksheetStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class SaveCircleWorksheetLoading extends SaveCircleWorksheetStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class SaveCircleWorksheetCompleted extends SaveCircleWorksheetStatus {
  final ShapeEntity shapeEntity;
  SaveCircleWorksheetCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class SaveCircleWorksheetError extends SaveCircleWorksheetStatus {
  final String? message;
  SaveCircleWorksheetError(this.message);

  @override
  List<Object?> get props => [message];
}
