// import 'package:appwrite/appwrite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
// import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/core/utils/storage_operator.dart';

GetIt locator = GetIt.instance;
// Client client = Client();

setup() async {
  // locator.registerSingleton<ApiProviderAuth>(ApiProviderAuth());
  // locator.registerSingleton<ApiProviderAddTodo>(ApiProviderAddTodo());
  // locator.registerSingleton<ApiProviderHome>(ApiProviderHome());

  // client
  //     .setEndpoint(Constants.baseUrl)
  //     .setProject('64d0ef46122980a6fcfb')
  //     // .setProject('TodoFlutter')
  //     .setSelfSigned(status: true);
  // locator.registerSingleton<Client>(client);

  const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  locator.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
  locator.registerSingleton<StorageOperator>(StorageOperator());

  /// repositories
  // locator.registerSingleton<UserRepository>(UserRepositoryImpl(locator()));
  // locator.registerSingleton<TodoRepository>(TodoRepositoryImpl(locator()));
  // locator.registerSingleton<HomeRepository>(HomeRepositoryImpl(locator()));

  /// use case
  // locator.registerSingleton<CallSignUpUseCase>(
  //   CallSignUpUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallLoginUseCase>(
  //   CallLoginUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallLoginAnnonymouslyUseCase>(
  //   CallLoginAnnonymouslyUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallAddTodoUseCase>(
  //   CallAddTodoUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallGetTodoUseCase>(
  //   CallGetTodoUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallUpdateIsCompletedTodoUseCase>(
  //   CallUpdateIsCompletedTodoUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallDeleteTodoUseCase>(
  //   CallDeleteTodoUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallUploadImageUseCase>(
  //   CallUploadImageUseCase(
  //     locator(),
  //   ),
  // );
  // locator.registerSingleton<CallLoginProviderUseCase>(
  //   CallLoginProviderUseCase(
  //     locator(),
  //   ),
  // );

  /// bloc features
  // locator.registerSingleton(AuthBloc(
  //   locator(),
  //   locator(),
  //   locator(),
  //   locator(),
  // ));
  // locator.registerSingleton(HomeBloc(
  //   locator(),
  //   locator(),
  //   locator(),
  // ));
  // locator.registerSingleton(UploadImageBloc(
  //   locator(),
  // ));
  // locator.registerSingleton(AddTodoBloc(
  //   locator(),
  // ));
}
