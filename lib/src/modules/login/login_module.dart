import 'package:delivery_backoffice_dw10/src/modules/login/login_controller.dart';
import 'package:delivery_backoffice_dw10/src/modules/login/login_page.dart';
import 'package:delivery_backoffice_dw10/src/repositories/auth/auth_repository.dart';
import 'package:delivery_backoffice_dw10/src/repositories/auth/auth_repository_impl.dart';
import 'package:delivery_backoffice_dw10/src/services/auth/login_service.dart';
import 'package:delivery_backoffice_dw10/src/services/auth/login_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(i())),
        Bind.lazySingleton<LoginService>((i) => LoginServiceImpl(i(), i())),
        Bind.lazySingleton((i) => LoginController(i()))
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const LoginPage())];
}
