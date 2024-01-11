import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';

class DeleteAllTempShapeUsecase extends UseCase<DataState<void>, NoParams> {
  final DocumentWorksheetRepository _textWorksheepRepository;
  DeleteAllTempShapeUsecase(this._textWorksheepRepository);

  @override
  Future<DataState<void>> call(NoParams param) {
    return _textWorksheepRepository.deleteAllTempShape();
  }
}
