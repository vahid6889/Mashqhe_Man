import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class GetAllWorksheetUsecase
    extends UseCase<DataState<List<WorksheetEntity?>>, WorksheetParams> {
  final WorkspaceRepository _workspaceRepository;
  GetAllWorksheetUsecase(this._workspaceRepository);

  @override
  Future<DataState<List<WorksheetEntity?>>> call(WorksheetParams param) {
    return _workspaceRepository.getAllWorksheetFromDB(param);
  }
}
