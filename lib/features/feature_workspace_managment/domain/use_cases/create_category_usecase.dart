import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/params/category_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class CreateCategoryUseCase
    implements UseCase<DataState<CategoryEntity>, CategoryParams> {
  final WorkspaceRepository _workspaceRepository;
  CreateCategoryUseCase(this._workspaceRepository);

  @override
  Future<DataState<CategoryEntity>> call(CategoryParams categoryParams) {
    return _workspaceRepository.saveCategoryToDB(categoryParams);
  }
}
