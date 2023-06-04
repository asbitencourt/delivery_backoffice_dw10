import 'package:delivery_backoffice_dw10/src/core/ui/helpers/loader.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/widget/order_header.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'detail/order_detail_modal.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messages {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer statusDisposer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case orderStateStatus.initial:
            break;
          case orderStateStatus.loading:
            showLoader();
            break;
          case orderStateStatus.loaded:
            hideLoader();
            break;
          case orderStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro Interno');
            break;
          case orderStateStatus.showDetailModal:
            hideLoader();
            showOrderDetail();
            break;
          case orderStateStatus.statusChanged:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.findOrdes();
            break;
        }
      });
      controller.findOrdes();
    });
  }

  void showOrderDetail() {
    showDialog(
        context: context,
        builder: (context) {
          return OrderDetailModal(
            orderController: controller,
            order: controller.orderSelected!,
          );
        });
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            OrderHeader(
              controller: controller,
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  return GridView.builder(
                      itemCount: controller.orders.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 91,
                        maxCrossAxisExtent: 600,
                      ),
                      itemBuilder: (context, index) {
                        return OrderItem(order: controller.orders[index]);
                      });
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
