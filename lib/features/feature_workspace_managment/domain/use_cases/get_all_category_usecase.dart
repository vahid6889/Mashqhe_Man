import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class GetAllCategoryUseCase
    implements UseCase<DataState<List<CategoryEntity>>, NoParams> {
  final WorkspaceRepository _workspaceRepository;
  GetAllCategoryUseCase(this._workspaceRepository);

  @override
  Future<DataState<List<CategoryEntity>>> call(NoParams noParams) {
    return _workspaceRepository.getAllCategoryFromDB();
  }
}
