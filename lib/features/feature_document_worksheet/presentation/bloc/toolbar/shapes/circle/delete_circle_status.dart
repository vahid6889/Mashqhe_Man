import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class DeleteCircleStatus extends Equatable {}

class DeleteCircleInitial extends DeleteCircleStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class DeleteCircleLoading extends DeleteCircleStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class DeleteCircleCompleted extends DeleteCircleStatus {
  final ShapeEntity shapeEntity;
  DeleteCircleCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class DeleteCircleError extends DeleteCircleStatus {
  final String? message;
  DeleteCircleError(this.message);

  @override
  List<Object?> get props => [message];
}
