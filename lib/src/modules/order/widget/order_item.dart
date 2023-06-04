import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/models/orders/order_model.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    return InkWell(
      onTap: () {
        context.read<OrderController>().showDetailModal(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Text(
                    'Pedido ',
                    style: textStyles.textBold,
                  ),
                  Text(order.id.toString(), style: textStyles.textExtraBold),
                  Expanded(
                      child: Text(
                    order.status.name,
                    textAlign: TextAlign.end,
                    style: textStyles.textExtraBold
                        .copyWith(fontSize: 20, color: order.status.color),
                  )),
                  const SizedBox(
                    width: 5,
                    height: double.infinity,
                  ),
                ]),
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
