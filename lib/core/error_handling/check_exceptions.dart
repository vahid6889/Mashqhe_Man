import 'package:mashgh/core/error_handling/app_exception.dart';
import 'package:mashgh/core/resources/data_state.dart';
// import 'package:mashgh/features/feature_home/domain/entities/top_market_coin_entity.dart';
import 'package:mashgh/features/feature_auth/domain/entities/user_entity.dart';
import 'package:dio/dio.dart';

// ignore: avoid_classes_with_only_static_members
class CheckExceptions {
  static Response response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response: response);
      case 401:
        throw UnauthorisedException();
      case 404:
        throw NotFoundException();
      case 500:
        throw ServerException();
      case 422:
        throw ServerException();
      default:
        throw FetchDataException(
          message: "پاسخی دریافت نشد",
        );
    }
  }

  // static Future<DataState<TopMarketCoinEntity>> getErrorMarket(
  //   AppException appException,
  // ) async {
  //   switch (appException.runtimeType) {
  //     /// return error came from server
  //     case BadRequestException _:
  //       return DataFailed(appException.message);

  //     case NotFoundException _:
  //       return DataFailed(appException.message);

  //     /// get refresh token and call api again
  //     case UnauthorisedException _:
  //       return DataFailed(appException.message);

  //     /// server error
  //     case ServerException _:
  //       return DataFailed(appException.message);

  //     /// dio or timeout and etc error
  //     case FetchDataException _:
  //       return DataFailed(appException.message);

  //     default:
  //       return DataFailed(appException.message);
  //   }
  // }

  static Future<DataState<UserEntity>> getError(
    AppException appException,
  ) async {
    switch (appException.runtimeType) {
      /// return error came from server
      case BadRequestException:
        return DataFailed(appException.message);

      case NotFoundException:
        return DataFailed(appException.message);

      /// get refresh token and call api again
      case UnauthorisedException:
        return DataFailed(appException.message);

      /// server error
      case ServerException:
        return DataFailed(appException.message);

      /// dio or timeout and etc error
      case FetchDataException:
        return DataFailed(appException.message);

      default:
        return DataFailed(appException.message);
    }
  }
}
