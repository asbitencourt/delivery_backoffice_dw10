import 'package:delivery_backoffice_dw10/src/modules/products/detail/product_detail_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/detail/product_detail_page.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/home/products_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home/products_page.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ProductsController(i())),
        Bind.lazySingleton((i) => ProductDetailController(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => ProductsPage()),
        ChildRoute('/detail',
            child: (context, args) => ProductDetailPage(
                  productId:
                      int.tryParse(args.queryParams['id'] ?? 'não informado'),
                ))
      ];
}
