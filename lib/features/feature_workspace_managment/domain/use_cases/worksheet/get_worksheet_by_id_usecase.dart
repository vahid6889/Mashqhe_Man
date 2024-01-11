import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';

class GetWorksheetByIdUsecase
    extends UseCase<DataState<WorksheetEntity?>, WorksheetParams> {
  final WorkspaceRepository _workspaceRepository;
  GetWorksheetByIdUsecase(this._workspaceRepository);

  @override
  Future<DataState<WorksheetEntity?>> call(WorksheetParams param) {
    return _workspaceRepository.getWorksheetByIdFromDB(param);
  }
}
