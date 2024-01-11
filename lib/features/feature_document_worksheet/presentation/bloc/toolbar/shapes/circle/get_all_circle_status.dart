import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class GetAllCircleStatus extends Equatable {}

class GetAllCircleInitial extends GetAllCircleStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class GetAllCircleLoading extends GetAllCircleStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class GetAllCircleCompleted extends GetAllCircleStatus {
  final List<ShapeEntity> shapeEntity;
  GetAllCircleCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class GetAllCircleError extends GetAllCircleStatus {
  final String? message;
  GetAllCircleError(this.message);

  @override
  List<Object?> get props => [message];
}
