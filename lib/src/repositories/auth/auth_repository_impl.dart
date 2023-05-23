import 'dart:developer';

import 'package:delivery_backoffice_dw10/src/core/exceptions/unauthorized_exception.dart';
import 'package:delivery_backoffice_dw10/src/models/auth_model.dart';
import 'package:delivery_backoffice_dw10/src/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl(this._dio);
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Login ou senha inválidos', error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      log('Erro ao realizar o login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar o login');
    }
  }
}
