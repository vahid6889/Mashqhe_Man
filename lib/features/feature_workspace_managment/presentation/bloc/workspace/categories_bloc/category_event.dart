part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetAllCategoryEvent extends CategoryEvent {
  GetAllCategoryEvent();
}

class CreateCategoryEvent extends CategoryEvent {
  final CategoryParams categoryParams;
  CreateCategoryEvent(this.categoryParams);
}

class CreateCategoryInitialEvent extends CategoryEvent {
  final NoParams noParams;

  CreateCategoryInitialEvent(this.noParams);
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryParams categoryParams;
  UpdateCategoryEvent(this.categoryParams);
}

class UpdateCategoryInitialEvent extends CategoryEvent {
  final NoParams noParams;

  UpdateCategoryInitialEvent(this.noParams);
}

class DeleteCategoryEvent extends CategoryEvent {
  final CategoryParams categoryParams;
  DeleteCategoryEvent(this.categoryParams);
}

class DeleteCategoryInitialEvent extends CategoryEvent {
  final NoParams noParams;

  DeleteCategoryInitialEvent(this.noParams);
}
