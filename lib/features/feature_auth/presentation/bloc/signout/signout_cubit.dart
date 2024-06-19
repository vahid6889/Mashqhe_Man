// import 'package:bloc/bloc.dart';
// import 'package:mashgh/core/usecase/use_case.dart';
// import 'package:mashgh/core/utils/storage_operator.dart';
// import 'package:mashgh/features/feature_auth/data/data_source/remote/api_provider_auth.dart';
// import 'package:mashgh/features/feature_auth/data/repository/user_repositoryImpl.dart';
// import 'package:mashgh/locator.dart';

// final StorageOperator storageOperator = locator();

// class SignOutCubit extends Cubit<bool> {
//   SignOutCubit() : super(false);

//   callSignOut() async {
//     final ApiProviderAuth apiProviderAuth = ApiProviderAuth();
//     UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl(apiProviderAuth);

//     NoParams noParams = NoParams();

//     final status = await userRepositoryImpl.callSignOutApi(noParams);

//     if (status == true) {
//       const sessionKey = 'rise_up_session';
//       storageOperator.destroyKey(sessionKey);
//     }

//     emit(status);
//   }
// }
