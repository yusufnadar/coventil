import 'dart:developer';

import 'package:coventil/src/common/view_model/user_view_model.dart';
import 'package:coventil/src/presentation/login/model/login_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../base/model/base_error_model.dart';
import '../../base/model/base_model.dart';
import '../../constants/end_points/app_end_point.dart';
import '../../constants/enums/http_type_enums.dart';
import '../../constants/local/app_locals.dart';
import '../local/local_service.dart';
import '../locator/locator_service.dart';

abstract class INetworkService {
  Future<Either<BaseErrorModel, Map<String, dynamic>?>> start<T extends BaseModel>(
    String path, {
    data,
    String? token,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    required HttpTypes httpTypes,
    T? parseModel,
  });
}

class NetworkService extends INetworkService with DioMixin {
  final Dio _dio;
  final LocalService _localService;

  NetworkService(this._dio, this._localService);

  void init() {
    _dio.options = BaseOptions(baseUrl: AppEndpoints.baseUrl);
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (DioException exception, ErrorInterceptorHandler handler) async {
        if (exception.response?.statusCode == 401) {
          await refreshToken(exception, handler);
        } else {
          return handler.next(exception);
        }
      }),
    );
  }

  @override
  Future<Either<BaseErrorModel, Map<String, dynamic>?>> start<T extends BaseModel>(
    String path, {
    data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required HttpTypes httpTypes,
    T? parseModel,
  }) async {
    try {
      final response = await sendRequest(path, data, httpTypes.name, queryParameters);
      log(response.data.toString());
      return Right(response.data);
    } on DioException catch (error) {
      print('There is an error ${error.response}');
      if (error.response?.data != null) {
        return Left(BaseErrorModel.fromJson(error.response?.data));
      } else {
        return Left(BaseErrorModel.fromJson({'message': error.toString()}));
      }
    } catch (error) {
      return Left(BaseErrorModel.fromJson({'message': error.toString()}));
    }
  }

  Future<Response> sendRequest(path, data, method, queryParameters) async {
    return await _dio.request<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method,
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          'Authorization': 'Bearer ${getIt<LocalService>().read(AppLocals.accessToken)}'
        },
      ),
    );
  }

  Future<void> refreshToken(DioException exception, ErrorInterceptorHandler handler) async {
    final res = await start(
      AppEndpoints.refreshToken,
      httpTypes: HttpTypes.post,
      data: {
        'tokenRequestModel': {
          'token':
              (exception.requestOptions.headers['Authorization'] as String).split('Bearer ')[1],
          'refreshToken': _localService.read(AppLocals.refreshToken),
        }
      },
    );
    res.fold(
      (error) {
        getIt<UserViewModel>().logout();
      },
      (result) async {
        final res = BaseModelI.fromJson(result!, LoginResponseModel());
        await _localService.write(AppLocals.accessToken, res.result!.token);
        await _localService.write(AppLocals.refreshToken, res.result!.refreshToken);
        await _localService.write(AppLocals.email, res.result!.email);
        await _localService.write(
          AppLocals.name,
          '${res.result!.firstName!} ${res.result!.lastName!}',
        );
        exception.requestOptions.headers['Authorization'] = 'Bearer ${res.result!.token}';
        return handler.resolve(await fetch(exception.requestOptions));
      },
    );
  }
}
