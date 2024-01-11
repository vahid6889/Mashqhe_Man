import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class SaveWorksheetShapesStatus extends Equatable {}

class SaveWorksheetShapesInitial extends SaveWorksheetShapesStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class SaveWorksheetShapesLoading extends SaveWorksheetShapesStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class SaveWorksheetShapesCompleted extends SaveWorksheetShapesStatus {
  final ShapeEntity shapeEntity;
  SaveWorksheetShapesCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class SaveWorksheetShapesError extends SaveWorksheetShapesStatus {
  final String? message;
  SaveWorksheetShapesError(this.message);

  @override
  List<Object?> get props => [message];
}
