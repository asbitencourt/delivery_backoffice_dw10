import 'package:delivery_backoffice_dw10/src/modules/order/order_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/order/order_page.dart';
import 'package:delivery_backoffice_dw10/src/repositories/order/order_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/order/order_repository_impl.dart';
import 'package:delivery_backoffice_dw10/src/services/order/get_order_by_id.dart';
import 'package:delivery_backoffice_dw10/src/services/order/get_order_by_id_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<OrderRepository>((i) => OrderRepositoryImpl(i())),
        Bind.lazySingleton<GetOrderById>(
          (i) => GetOrderByIdImpl(i(), i(), i()),
        ),
        Bind.lazySingleton((i) => OrderController(i(), i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => OrderPage())];
}
