// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/delete_all_temp_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/delete_worksheets_shapes_by_unique_id_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/save_temp_document_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/shapes_save_trigger_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/worksheet/document/delete_all_worksheets_shape_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/worksheet/document/save_worksheet_shapes_status.dart';
import 'package:mashgh/locator.dart';
import 'package:meta/meta.dart';

import 'save_temp_document_status.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final SaveTempDocumentUsecase _saveTempDocumentUsecase;
  final ShapesSaveTriggerUsecase _shapesSaveTriggerUsecase;
  final DeleteShapeByWorksheetUniqueIdUsecase
      _deleteShapeByWorksheetUniqueIdUsecase;
  final DeleteAllTempShapeUsecase _deleteAllTempShapeUsecase;

  DocumentBloc(
    this._saveTempDocumentUsecase,
    this._shapesSaveTriggerUsecase,
    this._deleteAllTempShapeUsecase,
    this._deleteShapeByWorksheetUniqueIdUsecase,
  ) : super(
          DocumentState(
            saveTempDocumentStatus: SaveTempDocumentInitial(),
            saveWorksheetShapesStatus: SaveWorksheetShapesLoading(),
            deleteAllWorksheetsShapeStatus: DeleteAllWorksheetsShapeLoading(),
          ),
        ) {
    on<SaveTempDocumentEvent>(
      (event, emit) async {
        final documentBloc = locator<DocumentBloc>();

        /// emit loading state
        emit(state.copyWith(
            newSaveTempDocumentStatus: SaveTempDocumentLoading()));

        if (state.saveTempDocumentStatus is SaveTempDocumentLoading) {
          ShapeParams shapeParams = ShapeParams(
            worksheetUniqueId: event.worksheetParams.uniqueId,
          );

          /// Deleting all previously saved temporary forms for the application that is supposed to update the new data based on the ID inside it
          documentBloc.add(DeleteShapesByWorksheetsUniqueIdEvent(shapeParams));
        }

        DataState dataState =
            await _saveTempDocumentUsecase(event.worksheetParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSaveTempDocumentStatus:
                  SaveTempDocumentCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newSaveTempDocumentStatus:
                  SaveTempDocumentError(dataState.error)));
        }
      },
    );

    on<ShapesSaveTriggerEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(
            newSaveWorksheetShapesStatus: SaveWorksheetShapesLoading()));

        DataState dataState =
            await _shapesSaveTriggerUsecase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSaveWorksheetShapesStatus:
                  SaveWorksheetShapesCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newSaveWorksheetShapesStatus:
                  SaveWorksheetShapesError(dataState.error)));
        }
      },
    );

    on<DeleteShapesByWorksheetsUniqueIdEvent>(
      (event, emit) async {
        final documentBloc = locator<DocumentBloc>();

        /// emit loading state
        emit(state.copyWith(
            newDeleteAllWorksheetsShapeStatus:
                DeleteAllWorksheetsShapeLoading()));

        DataState dataState =
            await _deleteShapeByWorksheetUniqueIdUsecase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          // ShapeEntity shapeEntity = ShapeEntity();
          emit(state.copyWith(
              newDeleteAllWorksheetsShapeStatus:
                  DeleteAllWorksheetsShapeCompleted(ShapeEntity())));

          ShapeParams shapeParams = ShapeParams(
            worksheetUniqueId: event.shapeParams.worksheetUniqueId,
          );

          /// update worksheetUniqueId temporary shapes with worksheet uniqueId when success save temporary worksheet
          documentBloc.add(ShapesSaveTriggerEvent(shapeParams));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newDeleteAllWorksheetsShapeStatus:
                  DeleteAllWorksheetsShapeError(dataState.error)));
        }
      },
    );

    on<DeleteAllTempShapeEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(
            newDeleteAllWorksheetsShapeStatus:
                DeleteAllWorksheetsShapeLoading()));

        DataState dataState = await _deleteAllTempShapeUsecase(NoParams());

        /// emit Complete state
        if (dataState is DataSuccess) {
          // ShapeEntity shapeEntity = ShapeEntity();
          emit(state.copyWith(
              newDeleteAllWorksheetsShapeStatus:
                  DeleteAllWorksheetsShapeCompleted(ShapeEntity())));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newDeleteAllWorksheetsShapeStatus:
                  DeleteAllWorksheetsShapeError(dataState.error)));
        }
      },
    );
  }
}
