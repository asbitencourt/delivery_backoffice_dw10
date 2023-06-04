import 'package:delivery_backoffice_dw10/src/core/global/global_context.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');
    Modular.setNavigatorKey(_navigatorKey);
    return MaterialApp.router(
      title: 'Application Name',
      theme: ThemeConfig.theme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
