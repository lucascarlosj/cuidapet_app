import 'package:cuidapet_app/app/core/helpers/constants.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_app/app/core/helpers/logger.dart';
import 'package:cuidapet_app/app/core/local_storages/local_security_storage.dart';
import 'package:cuidapet_app/app/core/local_storages/local_storage.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final LocalSecurityStorage _localSecurityStorage;
  final Logger _log;

  AuthInterceptor({
    required LocalStorage localStorage,
    required LocalSecurityStorage localSecurityStorage,
    required Logger log,
  })  : _localStorage = localStorage,
        _localSecurityStorage = localSecurityStorage,
        _log = log;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['auth_required'] == true) {
      final accessToken =
          await _localStorage.read<String>(Constants.ACCESS_TOKEN_KEY);
      // Se nao tiver token faço o logout e no dio eu bloqueio a requisicao de continuar
      if (accessToken == null) {
        // Logout!!!
        handler.reject(
          DioError(
              requestOptions: options,
              error: 'Expire Token',
              type: DioErrorType.cancel),
        );
      }
      options.headers['Authorization'] = accessToken;
    }

    if (!kReleaseMode) {
      _log.append('################### REQUEST LOG ###################');
      _log.append('URL: ${options.uri}');
      _log.append('DATA: ${options.data}');
      _log.append('HEADERS: ${options.headers}');
      _log.append('################### REQUEST LOG ###################');
      _log.closeAppend();
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      _log.append('################### RESPONSE LOG ###################');
      _log.append('DATA: ${response.data}');
      _log.append('################### RESPONSE LOG ###################');
      _log.closeAppend();
    }

    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _log.append('################### ERROR LOG ###################');
    _log.append('ERROR: ${err.response}');
    _log.append('################### ERROR LOG ###################');
    _log.closeAppend();

    handler.next(err);
  }
}
