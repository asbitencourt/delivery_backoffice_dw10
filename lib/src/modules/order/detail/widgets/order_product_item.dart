import 'package:delivery_backoffice_dw10/src/core/extensions/formatter_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/dto/order/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderProductItem extends StatelessWidget {
  final OrderProductDto orderProduct;
  const OrderProductItem({super.key, required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Text(
            orderProduct.product.name,
            style: context.textStyles.textRegular,
          )),
          Text('${orderProduct.amount}', style: context.textStyles.textRegular),
          Expanded(
              child: Text(
            orderProduct.totalPrice.currencyPTBR,
            style: context.textStyles.textRegular,
            textAlign: TextAlign.end,
          )),
        ],
      ),
    );
  }
}
