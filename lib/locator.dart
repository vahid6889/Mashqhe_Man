import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mashgh/core/data/db/local/database.dart';
// import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_auth/data/data_source/remote/api_provider_auth.dart';
import 'package:mashgh/features/feature_auth/data/repository/user_repositoryImpl.dart';
import 'package:mashgh/features/feature_auth/domain/repository/user_repository.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_generate_otp_usecase.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_login_otp_usecase.dart';
import 'package:mashgh/features/feature_auth/domain/use_cases/call_update_user_profile_usecase.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/data/repository/document_worksheet_repositoryimpl.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/repository/document_worksheet_repository.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/delete_all_temp_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/delete_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/get_all_circle_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/save_shape_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/delete_worksheets_shapes_by_unique_id_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/shapes_save_trigger_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/shapes/circle/update_shape_content_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/worksheet/save_temp_document_usecase.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/worksheet/document/document_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/data/repository/workspace_repositoryimpl.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/repository/workspace_repository.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/create_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/delete_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/get_all_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/update_category_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/delete_worksheet_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/get_all_worksheet_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/domain/use_cases/worksheet/get_worksheet_by_id_usecase.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/category_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/workspace_worksheet_bloc.dart';

GetIt locator = GetIt.instance;
// Client client = Client();

setup() async {
  locator.registerSingleton<ApiProviderAuth>(ApiProviderAuth());

  /// databases
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);
  const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  locator.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
  locator.registerSingleton<StorageOperator>(StorageOperator());

  /// repositories
  locator.registerSingleton<UserRepository>(UserRepositoryImpl(locator()));
  locator.registerSingleton<DocumentWorksheetRepository>(
      DocumentWorksheetRepositoryImpl(
    database.shapesDao,
    database.worksheetDao,
  ));
  locator.registerSingleton<WorkspaceRepository>(WorkspaceRepositoryImpl(
    database.categoryDao,
    database.worksheetDao,
  ));

  /// use case
  locator
      .registerSingleton<GetAllCircleUseCase>(GetAllCircleUseCase(locator()));
  locator.registerSingleton<SaveShapeUsecase>(SaveShapeUsecase(locator()));
  locator.registerSingleton<UpdateShapeContentUsecase>(
      UpdateShapeContentUsecase(locator()));
  locator.registerSingleton<DeleteShapeUsecase>(DeleteShapeUsecase(locator()));
  locator.registerSingleton<GetAllCategoryUseCase>(
      GetAllCategoryUseCase(locator()));
  locator.registerSingleton<CreateCategoryUseCase>(
      CreateCategoryUseCase(locator()));
  locator.registerSingleton<UpdateCategoryUseCase>(
      UpdateCategoryUseCase(locator()));
  locator.registerSingleton<DeleteCategoryUseCase>(
      DeleteCategoryUseCase(locator()));
  locator.registerSingleton<SaveTempDocumentUsecase>(
      SaveTempDocumentUsecase(locator()));
  locator.registerSingleton<GetAllWorksheetUsecase>(
      GetAllWorksheetUsecase(locator()));
  locator.registerSingleton<GetWorksheetByIdUsecase>(
      GetWorksheetByIdUsecase(locator()));
  locator.registerSingleton<DeleteWorksheetUsecase>(
      DeleteWorksheetUsecase(locator()));
  locator.registerSingleton<DeleteAllTempShapeUsecase>(
      DeleteAllTempShapeUsecase(locator()));
  locator.registerSingleton<ShapesSaveTriggerUsecase>(
      ShapesSaveTriggerUsecase(locator()));
  locator.registerSingleton<DeleteShapeByWorksheetUniqueIdUsecase>(
      DeleteShapeByWorksheetUniqueIdUsecase(locator()));
  locator.registerSingleton<CallGenerateOtpUseCase>(
      CallGenerateOtpUseCase(locator()));
  locator
      .registerSingleton<CallLoginOtpUseCase>(CallLoginOtpUseCase(locator()));
  locator.registerSingleton<CallUpdateUserProfileUseCase>(
      CallUpdateUserProfileUseCase(locator()));

  /// bloc features
  locator.registerSingleton(AuthBloc(
    locator(),
    locator(),
    locator(),
  ));
  locator.registerSingleton(
    CircleBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerSingleton(
    CategoryBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerSingleton(
    DocumentBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerSingleton(
    WorkspaceWorksheetBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
}
