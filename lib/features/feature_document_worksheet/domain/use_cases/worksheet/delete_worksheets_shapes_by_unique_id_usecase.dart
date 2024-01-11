import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';

class DeleteShapeByWorksheetUniqueIdUsecase
    extends UseCase<DataState<String>, ShapeParams> {
  final DocumentWorksheetRepository _textWorksheepRepository;
  DeleteShapeByWorksheetUniqueIdUsecase(this._textWorksheepRepository);

  @override
  Future<DataState<String>> call(ShapeParams param) {
    return _textWorksheepRepository.deleteShapeByWorksheetUniqueId(param);
  }
}
