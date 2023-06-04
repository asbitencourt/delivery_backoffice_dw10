import 'package:delivery_backoffice_dw10/src/core/extensions/formatter_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/size_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/dto/order/order_dto.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/detail/widgets/order_bottom_bar.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/detail/widgets/order_info_tile.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/detail/widgets/order_product_item.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:flutter/material.dart';

class OrderDetailModal extends StatefulWidget {
  final OrderController orderController;
  final OrderDto order;
  const OrderDetailModal(
      {super.key, required this.orderController, required this.order});

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? 0.5 : 0.7),
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Detalhe do Pedido',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: _closeModal, icon: Icon(Icons.close))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Nome Cliente: ',
                    style: context.textStyles.textBold,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(widget.order.user.name),
                ],
              ),
              Divider(),
              ...widget.order.orderProducts
                  .map((op) => OrderProductItem(orderProduct: op))
                  .toList(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total do Pedido: ',
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 18),
                    ),
                    Text(
                      widget.order.orderProducts
                          .fold<double>(
                            0.0,
                            (previousValue, p) => previousValue + p.totalPrice,
                          )
                          .currencyPTBR,
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Divider(),
              OrderInfoTile(
                  label: 'Endereço de entrega:', info: widget.order.address),
              Divider(),
              OrderInfoTile(
                  label: 'Forma de Pagamento:',
                  info: widget.order.paymentTypeModel.name),
              const SizedBox(
                height: 10,
              ),
              OrderBottomBar(
                  controller: widget.orderController, order: widget.order),
            ]),
          ),
        ),
      ),
    );
  }
}
