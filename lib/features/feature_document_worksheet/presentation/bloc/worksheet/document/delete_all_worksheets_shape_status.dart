import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class DeleteAllWorksheetsShapeStatus extends Equatable {}

class DeleteAllWorksheetsShapeInitial extends DeleteAllWorksheetsShapeStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class DeleteAllWorksheetsShapeLoading extends DeleteAllWorksheetsShapeStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class DeleteAllWorksheetsShapeCompleted extends DeleteAllWorksheetsShapeStatus {
  final ShapeEntity shapeEntity;
  DeleteAllWorksheetsShapeCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class DeleteAllWorksheetsShapeError extends DeleteAllWorksheetsShapeStatus {
  final String? message;
  DeleteAllWorksheetsShapeError(this.message);

  @override
  List<Object?> get props => [message];
}
