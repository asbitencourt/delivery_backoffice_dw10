import 'dart:developer';

import 'package:delivery_backoffice_dw10/src/dto/order/order_dto.dart';
import 'package:delivery_backoffice_dw10/src/models/orders/order_model.dart';
import 'package:delivery_backoffice_dw10/src/models/orders/order_status.dart';
import 'package:delivery_backoffice_dw10/src/repositories/order/order_repository.dart';
import 'package:delivery_backoffice_dw10/src/services/order/get_order_by_id.dart';
import 'package:mobx/mobx.dart';
part 'order_controller.g.dart';

enum orderStateStatus {
  initial,
  loading,
  loaded,
  error,
  showDetailModal,
  statusChanged,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  final GetOrderById _getOrderById;
  @readonly
  var _status = orderStateStatus.initial;
  late final DateTime _today;
  @readonly
  OrderStatus? _statusFilter;
  @readonly
  var _orders = <OrderModel>[];
  @readonly
  String? _errorMessage;
  @readonly
  OrderDto? _orderSelected;

  OrderControllerBase(this._orderRepository, this._getOrderById) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  void changeStatusFilter(OrderStatus? status) {
    _statusFilter = status;
    findOrdes();
  }

  @action
  Future<void> findOrdes() async {
    try {
      _status = orderStateStatus.loading;
      _orders = await _orderRepository.findAllOrders(_today, _statusFilter);
      _status = orderStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar pedidos do dia', error: e, stackTrace: s);
      _status = orderStateStatus.error;
      _errorMessage = 'Erro ao buscar pedidos do dia';
    }
  }

  @action
  Future<void> showDetailModal(OrderModel orderModel) async {
    _status = orderStateStatus.loading;
    _orderSelected = await _getOrderById(orderModel);

    _status = orderStateStatus.showDetailModal;
  }

  @action
  Future<void> changedStatus(OrderStatus status) async {
    _status = orderStateStatus.initial;
    await _orderRepository.changeStatus(_orderSelected!.id, status);
    _status = orderStateStatus.statusChanged;
  }
}
