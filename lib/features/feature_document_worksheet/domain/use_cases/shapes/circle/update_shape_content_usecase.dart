import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';

class UpdateShapeContentUsecase
    extends UseCase<DataState<ShapeEntity>, ShapeParams> {
  final DocumentWorksheetRepository _textWorksheepRepository;
  UpdateShapeContentUsecase(this._textWorksheepRepository);

  @override
  Future<DataState<ShapeEntity>> call(ShapeParams param) {
    return _textWorksheepRepository.updateShapeContentToDB(param);
  }
}
