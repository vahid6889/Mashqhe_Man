part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final GetAllCategoryStatus getAllCategoryStatus;
  final CreateCategoryStatus createCategoryStatus;
  final UpdateCategoryStatus updateCategoryStatus;
  final DeleteCategoryStatus deleteCategoryStatus;

  const CategoryState({
    required this.getAllCategoryStatus,
    required this.createCategoryStatus,
    required this.updateCategoryStatus,
    required this.deleteCategoryStatus,
  });

  CategoryState copyWith({
    GetAllCategoryStatus? newGetAllCategoryStatus,
    CreateCategoryStatus? newCreateCategoryStatus,
    UpdateCategoryStatus? newUpdateCategoryStatus,
    DeleteCategoryStatus? newDeleteCategoryStatus,
  }) {
    return CategoryState(
      getAllCategoryStatus: newGetAllCategoryStatus ?? getAllCategoryStatus,
      createCategoryStatus: newCreateCategoryStatus ?? createCategoryStatus,
      updateCategoryStatus: newUpdateCategoryStatus ?? updateCategoryStatus,
      deleteCategoryStatus: newDeleteCategoryStatus ?? deleteCategoryStatus,
    );
  }

  @override
  List<Object?> get props => [
        getAllCategoryStatus,
        createCategoryStatus,
        updateCategoryStatus,
        deleteCategoryStatus,
      ];
}
