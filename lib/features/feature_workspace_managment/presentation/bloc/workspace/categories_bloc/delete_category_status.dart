import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

abstract class DeleteCategoryStatus extends Equatable {}

class DeleteCategoryInitial extends DeleteCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loading state
class DeleteCategoryLoading extends DeleteCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class DeleteCategoryCompleted extends DeleteCategoryStatus {
  final CategoryEntity categoryEntity;
  DeleteCategoryCompleted(this.categoryEntity);

  @override
  List<Object?> get props => [categoryEntity];
}

/// error state
class DeleteCategoryError extends DeleteCategoryStatus {
  final String? message;
  DeleteCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
