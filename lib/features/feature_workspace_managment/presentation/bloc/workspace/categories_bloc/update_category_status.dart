import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

abstract class UpdateCategoryStatus extends Equatable {}

class UpdateCategoryInitial extends UpdateCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class UpdateCategoryLoading extends UpdateCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class UpdateCategoryCompleted extends UpdateCategoryStatus {
  final CategoryEntity categoryEntity;
  UpdateCategoryCompleted(this.categoryEntity);

  @override
  List<Object?> get props => [categoryEntity];
}

/// error state
class UpdateCategoryError extends UpdateCategoryStatus {
  final String? message;
  UpdateCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
