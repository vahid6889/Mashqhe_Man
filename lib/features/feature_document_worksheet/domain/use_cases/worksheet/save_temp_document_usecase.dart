import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';

class SaveTempDocumentUsecase
    extends UseCase<DataState<WorksheetEntity>, WorksheetParams> {
  final DocumentWorksheetRepository _textWorksheepRepository;
  SaveTempDocumentUsecase(this._textWorksheepRepository);

  @override
  Future<DataState<WorksheetEntity>> call(WorksheetParams param) {
    return _textWorksheepRepository.saveTempDocumentToDB(param);
  }
}
