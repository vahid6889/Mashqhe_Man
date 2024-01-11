import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

abstract class GetAllCategoryStatus extends Equatable {}

/// loading state
class GetAllCategoryLoading extends GetAllCategoryStatus {
  @override
  List<Object?> get props => [];
}

/// loaded state
class GetAllCategoryCompleted extends GetAllCategoryStatus {
  final List<CategoryEntity> categoryEntity;
  GetAllCategoryCompleted(this.categoryEntity);

  @override
  List<Object?> get props => [categoryEntity];
}

/// error state
class GetAllCategoryError extends GetAllCategoryStatus {
  final String? message;
  GetAllCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
