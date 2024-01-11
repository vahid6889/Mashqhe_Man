import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mashgh/core/params/category_params.dart';
import 'package:mashgh/core/resources/data_state.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/create_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/delete_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/get_all_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/update_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/create_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/delete_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/get_all_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/update_category_status.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  Map<int, Map<String, int>> categoryList = {};

  final GetAllCategoryUseCase _getAllCategoryUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  CategoryBloc(
    this._getAllCategoryUseCase,
    this._createCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
  ) : super(
          CategoryState(
            getAllCategoryStatus: GetAllCategoryLoading(),
            createCategoryStatus: CreateCategoryInitial(),
            updateCategoryStatus: UpdateCategoryInitial(),
            deleteCategoryStatus: DeleteCategoryInitial(),
          ),
        ) {
    /// get All categories
    on<GetAllCategoryEvent>(
      (event, emit) async {
        /// emit Loading state
        emit(state.copyWith(newGetAllCategoryStatus: GetAllCategoryLoading()));

        DataState dataState = await _getAllCategoryUseCase(NoParams());

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newGetAllCategoryStatus: GetAllCategoryCompleted(dataState.data),
            ),
          );
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newGetAllCategoryStatus: GetAllCategoryError(dataState.error),
            ),
          );
        }
      },
    );

    /// insert new category
    on<CreateCategoryEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(newCreateCategoryStatus: CreateCategoryLoading()));

        DataState dataState =
            await _createCategoryUseCase(event.categoryParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newCreateCategoryStatus:
                  CreateCategoryCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newCreateCategoryStatus: CreateCategoryError(dataState.error)));
        }
      },
    );
    on<CreateCategoryInitialEvent>((event, emit) async {
      emit(state.copyWith(newCreateCategoryStatus: CreateCategoryInitial()));
    });

    /// update category
    on<UpdateCategoryEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(newUpdateCategoryStatus: UpdateCategoryLoading()));

        DataState dataState =
            await _updateCategoryUseCase(event.categoryParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newUpdateCategoryStatus:
                  UpdateCategoryCompleted(dataState.data)));
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(state.copyWith(
              newUpdateCategoryStatus: UpdateCategoryError(dataState.error)));
        }
      },
    );
    on<UpdateCategoryInitialEvent>((event, emit) async {
      emit(state.copyWith(newUpdateCategoryStatus: UpdateCategoryInitial()));
    });

    /// delete category
    on<DeleteCategoryEvent>(
      (event, emit) async {
        /// emit loading state
        emit(state.copyWith(newDeleteCategoryStatus: DeleteCategoryLoading()));

        DataState dataState =
            await _deleteCategoryUseCase(event.categoryParams);

        /// emit Complete state
        if (dataState is DataSuccess) {
          emit(
            state.copyWith(
              newDeleteCategoryStatus: DeleteCategoryCompleted(dataState.data),
            ),
          );
        }

        /// emit Error state
        if (dataState is DataFailed) {
          emit(
            state.copyWith(
              newDeleteCategoryStatus: DeleteCategoryError(dataState.error),
            ),
          );
        }
      },
    );
    on<DeleteCategoryInitialEvent>((event, emit) async {
      emit(state.copyWith(newDeleteCategoryStatus: DeleteCategoryInitial()));
    });
  }
}
