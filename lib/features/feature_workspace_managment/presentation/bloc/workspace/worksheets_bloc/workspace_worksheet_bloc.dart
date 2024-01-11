// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/delete_worksheet_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/get_all_worksheet_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/get_worksheet_by_id_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/delete_worksheet_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/get_all_worksheet_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/get_worksheet_by_id_status.dart';
import 'package:meta/meta.dart';

part 'worksheet_event.dart';
part 'worksheet_state.dart';

class WorkspaceWorksheetBloc extends Bloc<WorksheetEvent, WorksheetState> {
  final GetAllWorksheetUsecase _getAllWorksheetUsecase;
  final GetWorksheetByIdUsecase _getWorksheetByIdUsecase;
  final DeleteWorksheetUsecase _deleteWorksheetUsecase;
  WorkspaceWorksheetBloc(
    this._getAllWorksheetUsecase,
    this._getWorksheetByIdUsecase,
    this._deleteWorksheetUsecase,
  ) : super(
          WorksheetState(
            getAllWorksheetStatus: GetAllWorksheetLoading(),
            getWorksheetByIdStatus: GetWorksheetByIdLoading(),
            deleteWorksheetStatus: DeleteWorksheetInitial(),
          ),
        ) {
    on<GetAllWorksheetEvent>(
      (event, emit) async {
        /// emit loading state
        emit(
            state.copyWith(newGetAllWorksheetStatus: GetAllWorksheetLoading()));

        DataState dataState =
            await _getAllWorksheetUsecase(event.worksheetParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newGetAllWorksheetStatus:
                  GetAllWorksheetCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newGetAllWorksheetStatus: GetAllWorksheetError(dataState.error)));
        }
      },
    );

    on<GetAllWorksheetInitialEvent>((event, emit) async {
      emit(state.copyWith(newGetAllWorksheetStatus: GetAllWorksheetInitial()));
    });

    on<GetWorksheetByIdEvent>((event, emit) async {
      /// emit loading state
      emit(
          state.copyWith(newGetWorksheetByIdStatus: GetWorksheetByIdLoading()));

      DataState dataState =
          await _getWorksheetByIdUsecase(event.worksheetParams);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetWorksheetByIdStatus:
                GetWorksheetByIdCompleted(dataState.data)));
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newGetWorksheetByIdStatus: GetWorksheetByIdError(dataState.error)));
      }
    });

    on<GetWorksheetByIdInitialEvent>((event, emit) async {
      emit(
          state.copyWith(newGetWorksheetByIdStatus: GetWorksheetByIdInitial()));
    });

    /// delete worksheet by id
    on<DeleteWorksheetEvent>(
      (event, emit) async {
        /// emit loading state
        emit(
            state.copyWith(newDeleteWorksheetStatus: DeleteWorksheetLoading()));

        DataState dataState = await _deleteWorksheetUsecase(event.worksheetId);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newDeleteWorksheetStatus:
                  DeleteWorksheetCompleted(dataState.data),
            ),
          );
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newDeleteWorksheetStatus: DeleteWorksheetError(dataState.error),
            ),
          );
        }
      },
    );

    on<DeleteWorksheetInitialEvent>((event, emit) async {
      emit(state.copyWith(newDeleteWorksheetStatus: DeleteWorksheetInitial()));
    });
  }
}
