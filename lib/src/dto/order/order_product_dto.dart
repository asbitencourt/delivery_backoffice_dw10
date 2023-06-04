// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_backoffice_dw10/src/models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;
  final double totalPrice;

  OrderProductDto({
    required this.product,
    required this.amount,
    required this.totalPrice,
  });
}
