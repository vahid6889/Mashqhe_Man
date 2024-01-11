import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class DeleteWorksheetUsecase extends UseCase<DataState<int>, int> {
  final WorkspaceRepository _workspaceRepository;
  DeleteWorksheetUsecase(this._workspaceRepository);

  @override
  Future<DataState<int>> call(int param) {
    return _workspaceRepository.deleteWorksheetById(param);
  }
}
