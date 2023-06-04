import 'package:delivery_backoffice_dw10/src/core/ui/helpers/loader.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/widgets/base_header.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/home/products_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Modular.get<ProductsController>();
  late final ReactionDisposer statusDisposer;
  final debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar os produtos');
            break;
          case ProductStateStatus.addOrUpdateProduct:
            hideLoader();
            final productSelected = controller.productSelected;
            var uri = '/products/detail';
            if (productSelected != null) {
              uri += '?id=${productSelected.id}';
            }
            await Modular.to.pushNamed(uri);
            controller.loadProducts();
            break;
        }
      });
      controller.loadProducts();
    });
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50]!,
      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(children: [
        BaseHeader(
          title: 'ADMINISTRAR PRODUTOS',
          buttonLabel: 'ADICIONAR PRODUTO',
          buttonPressed: controller.addProduct,
          searchChange: (value) {
            debouncer.call(() {
              controller.filterByName(value);
            });
          },
        ),
        const SizedBox(
          height: 50,
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 280,
                      mainAxisSpacing: 20,
                      maxCrossAxisExtent: 280,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return ProductItem(product: controller.products[index]);
                  });
            },
          ),
        )
      ]),
    );
  }
}
