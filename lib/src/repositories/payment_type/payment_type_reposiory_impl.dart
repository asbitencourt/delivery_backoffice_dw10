// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:delivery_backoffice_dw10/src/core/exceptions/repository_exception.dart';
import 'package:delivery_backoffice_dw10/src/core/rest_client/custom_dio.dart';
import 'package:delivery_backoffice_dw10/src/models/payment_type_model.dart';

import '../payment_type/payment_type_repository.dart';

class PaymentTypeReposioryImpl implements PaymentTypeRepository {
  final CustomDio _customDio;

  PaymentTypeReposioryImpl(this._customDio);

  @override
  Future<List<PaymentTypeModel>> findAll(bool? enabled) async {
    try {
      final paymentResult = await _customDio.auth().get(
        '/payment-types',
        queryParameters: {
          if (enabled != null) 'enabled': enabled,
        },
      );
      return paymentResult.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('$e', error: e, stackTrace: s);
    }
    throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
  }

  @override
  Future<PaymentTypeModel> getById(int id) async {
    try {
      final paymentResult = await _customDio.auth().get(
            '/payment-types/$id',
          );
      return PaymentTypeModel.fromMap(paymentResult.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar forma de pagamento $id', error: e, stackTrace: s);
    }
    throw RepositoryException(message: 'Erro ao buscar forma de pagamento $id');
  }

  @override
  Future<void> save(PaymentTypeModel model) async {
    try {
      final client = _customDio.auth();
      if (model.id != null) {
        await client.put(
          '/payment-types/${model.id}',
          data: model.toMap(),
        );
      } else {
        await client.post(
          '/payment-types/',
          data: model.toMap(),
        );
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar forma de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar forma de pagamento');
    }
  }
}
