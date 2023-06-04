// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_backoffice_dw10/src/dto/order/order_product_dto.dart';
import 'package:delivery_backoffice_dw10/src/models/orders/order_status.dart';
import 'package:delivery_backoffice_dw10/src/models/payment_type_model.dart';

import '../../models/user_model.dart';

class OrderDto {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final UserModel user;
  final String address;
  final int cpf;
  final PaymentTypeModel paymentTypeModel;

  OrderDto({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProducts,
    required this.user,
    required this.address,
    required this.cpf,
    required this.paymentTypeModel,
  });
}
