// ignore_for_file: unused_field
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/delete_all_temp_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/delete_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/get_all_circle_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/save_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/shapes_save_trigger_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/delete_circle_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/get_all_circle_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/save_circle_toolbar_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/save_circle_worksheet_status.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  final GetAllCircleUseCase _getAllCircleUseCase;
  final SaveShapeUsecase _saveShapeUsecase;
  final DeleteShapeUsecase _deleteShapeUsecase;
  Map<String, Map<String, dynamic>> positionsCircle = {};
  // Map<String, Offset> positionsDiamond = {};
  // Map<String, Offset> positionsRectangle = {};
  // Map<String, Offset> positionsSquare = {};
  // Map<String, Offset> positionsTriangle = {};

  CircleBloc(
    this._getAllCircleUseCase,
    this._saveShapeUsecase,
    this._deleteShapeUsecase,
  ) : super(CircleState(
          getAllCircleStatus: GetAllCircleLoading(),
          saveCircleToolbarStatus: SaveCircleToolbarInitial(),
          saveCircleWorksheetStatus: SaveCircleWorksheetInitial(),
          deleteCircleStatus: DeleteCircleInitial(),
        )) {
    /// get All shapes/circle
    on<GetAllCircleEvent>(
      (event, emit) async {
        /// emit Loading state
        emit(state.copyWith(newGetAllCircleStatus: GetAllCircleLoading()));

        DataState dataState = await _getAllCircleUseCase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newGetAllCircleStatus: GetAllCircleCompleted(dataState.data),
            ),
          );
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newGetAllCircleStatus: GetAllCircleError(dataState.error),
            ),
          );
        }
      },
    );
    on<GetAllCircleInitialEvent>(
      (event, emit) async {
        positionsCircle = {};
        emit(state.copyWith(newGetAllCircleStatus: GetAllCircleInitial()));
      },
    );
    on<SaveCirlceToolbarEvent>((event, emit) async {
      /// emit loading state
      emit(state.copyWith(
          newSaveCircleToolbarStatus: SaveCircleToolbarLoading()));

      DataState dataState = await _saveShapeUsecase(event.shapeParams);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newSaveCircleToolbarStatus:
                SaveCircleToolbarCompleted(dataState.data)));
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newSaveCircleToolbarStatus:
                SaveCircleToolbarError(dataState.error)));
      }
    });
    on<SaveCircleToolbarInitialEvent>(
      (event, emit) async {
        emit(state.copyWith(
            newSaveCircleToolbarStatus: SaveCircleToolbarInitial()));
      },
    );
    on<SaveCirlceWorksheetEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(
            newSaveCircleWorksheetStatus: SaveCircleWorksheetLoading()));

        DataState dataState = await _saveShapeUsecase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSaveCircleWorksheetStatus:
                  SaveCircleWorksheetCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newSaveCircleWorksheetStatus:
                  SaveCircleWorksheetError(dataState.error)));
        }
      },
    );
    on<SaveCircleWorksheetInitialEvent>(
      (event, emit) async {
        emit(state.copyWith(
            newSaveCircleWorksheetStatus: SaveCircleWorksheetInitial()));
      },
    );
    on<UpdateCirlceContentEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(
            newSaveCircleToolbarStatus: SaveCircleToolbarLoading()));

        DataState dataState = await _saveShapeUsecase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSaveCircleToolbarStatus:
                  SaveCircleToolbarCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newSaveCircleToolbarStatus:
                  SaveCircleToolbarError(dataState.error)));
        }
      },
    );
    on<DeleteCirlceEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(newDeleteCircleStatus: DeleteCircleLoading()));

        DataState dataState = await _deleteShapeUsecase(event.shapeParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newDeleteCircleStatus: DeleteCircleCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newDeleteCircleStatus: DeleteCircleError(dataState.error)));
        }
      },
    );
  }
}
