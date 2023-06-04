import 'dart:typed_data';

import 'package:delivery_backoffice_dw10/src/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAll(String? name);
  Future<ProductModel> getProduct(int id);
  Future<void> save(ProductModel productModel);
  Future<String> uploadImageProduct(Uint8List file, String filename);
  Future<void> deleteProduct(int id);
}
