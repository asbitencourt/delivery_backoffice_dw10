import 'package:delivery_backoffice_dw10/src/models/orders/order_status.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';

class OrderHeader extends StatefulWidget {
  final OrderController controller;
  const OrderHeader({super.key, required this.controller});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? statusSelected;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Administrar Pedidos',
      addButton: false,
      filterWidget: DropdownButton<OrderStatus?>(
        value: null,
        items: [
          DropdownMenuItem(value: null, child: Text('Todos')),
          ...OrderStatus.values
              .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
              .toList()
        ],
        onChanged: (value) {
          setState(() {
            widget.controller.changeStatusFilter(value);
            statusSelected = value;
          });
        },
      ),
    );
  }
}
