import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';

abstract class SaveCircleToolbarStatus extends Equatable {}

class SaveCircleToolbarInitial extends SaveCircleToolbarStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class SaveCircleToolbarLoading extends SaveCircleToolbarStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class SaveCircleToolbarCompleted extends SaveCircleToolbarStatus {
  final ShapeEntity shapeEntity;
  SaveCircleToolbarCompleted(this.shapeEntity);

  @override
  List<Object?> get props => [shapeEntity];
}

/// error state
class SaveCircleToolbarError extends SaveCircleToolbarStatus {
  final String? message;
  SaveCircleToolbarError(this.message);

  @override
  List<Object?> get props => [message];
}
