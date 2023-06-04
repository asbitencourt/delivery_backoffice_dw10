// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_backoffice_dw10/src/core/global/constants.dart';
import 'package:dio/dio.dart';

import 'package:delivery_backoffice_dw10/src/storage/storage.dart';

import '../../global/global_context.dart';

class AuthInterceptor extends Interceptor {
  final Storage storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = storage.getData(SessionStorageKeys.accessToken.key);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      GlobalContext.instance.loginExpire();
    } else {
      handler.next(err);
    }
  }
}
