import 'package:delivery_backoffice_dw10/src/modules/core/core_module.dart';
import 'package:delivery_backoffice_dw10/src/modules/payment_type/payment_type_module.dart';
import 'package:delivery_backoffice_dw10/src/modules/products/products_module.dart';
import 'package:delivery_backoffice_dw10/src/modules/template/base_layout.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/login/login_module.dart';
import 'modules/order/order_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/login', module: LoginModule()),
        ChildRoute('/',
            child: (context, args) => const BaseLayout(body: RouterOutlet()),
            transition: TransitionType.noTransition,
            children: [
              ModuleRoute('/payment_type', module: PaymentTypeModule()),
              ModuleRoute('/products', module: ProductsModule()),
              ModuleRoute('/order', module: OrderModule()),
            ]),
      ];
}
