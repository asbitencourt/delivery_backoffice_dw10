import 'dart:developer';

import 'package:delivery_backoffice_dw10/src/core/exceptions/repository_exception.dart';
import 'package:delivery_backoffice_dw10/src/core/rest_client/custom_dio.dart';
import 'package:delivery_backoffice_dw10/src/models/user_model.dart';
import 'package:delivery_backoffice_dw10/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  final CustomDio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<UserModel> getById(int id) async {
    try {
      final userResponse = await _dio.auth().get('/users/$id');
      return UserModel.fromMap(userResponse.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar o usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar o usuário');
    }
  }
}
