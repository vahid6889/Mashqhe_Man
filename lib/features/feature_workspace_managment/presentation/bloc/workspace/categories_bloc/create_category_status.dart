import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

abstract class CreateCategoryStatus extends Equatable {}

class CreateCategoryInitial extends CreateCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class CreateCategoryLoading extends CreateCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class CreateCategoryCompleted extends CreateCategoryStatus {
  final CategoryEntity categoryEntity;
  CreateCategoryCompleted(this.categoryEntity);

  @override
  List<Object?> get props => [categoryEntity];
}

/// error state
class CreateCategoryError extends CreateCategoryStatus {
  final String? message;
  CreateCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
