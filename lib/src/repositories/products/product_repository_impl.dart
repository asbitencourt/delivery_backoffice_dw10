// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:delivery_backoffice_dw10/src/core/exceptions/repository_exception.dart';
import 'package:delivery_backoffice_dw10/src/core/rest_client/custom_dio.dart';
import 'package:delivery_backoffice_dw10/src/models/product_model.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/product_repository.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio _dio;

  ProductRepositoryImpl(
    this._dio,
  );

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _dio.auth().put(
        '/products/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao Deletar Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao Deletar Produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productResult = await _dio.auth().get(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );
      return productResult.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar os Produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar os Produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final productResult = await _dio.auth().get(
            '/products/$id',
          );
      return ProductModel.fromMap(productResult.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar o Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar o Produto');
    }
  }

  @override
  Future<void> save(ProductModel productModel) async {
    try {
      final client = _dio.auth();
      final data = productModel.toMap();
      if (productModel.id != null) {
        await client.put('/products/${productModel.id}', data: data);
      } else {
        await client.post('/products', data: data);
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar o Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar o Produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String filename) async {
    try {
      final formData = FormData.fromMap(
        {
          'file': MultipartFile.fromBytes(file, filename: filename),
        },
      );

      final response = await _dio.auth().post('/uploads', data: formData);
      return response.data['url'];
    } on Error catch (e, s) {
      log('Erro ao fazer upload do arquivo', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao fazer upload do arquivo');
    }
  }
}
