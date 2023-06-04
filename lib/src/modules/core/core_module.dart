import 'package:delivery_backoffice_dw10/src/core/rest_client/custom_dio.dart';
import 'package:delivery_backoffice_dw10/src/repositories/payment_type/payment_type_reposiory_impl.dart';
import 'package:delivery_backoffice_dw10/src/repositories/products/product_repository_impl.dart';
import 'package:delivery_backoffice_dw10/src/repositories/user/user_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/user/user_repository_impl.dart';
import 'package:delivery_backoffice_dw10/src/storage/session_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../storage/storage.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton((i) => CustomDio(i()), export: true),
        Bind.lazySingleton<PaymentTypeRepository>(
            (i) => PaymentTypeReposioryImpl(i()),
            export: true),
        Bind.lazySingleton<ProductRepository>((i) => ProductRepositoryImpl(i()),
            export: true),
        Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(i()),
            export: true),
      ];
}
