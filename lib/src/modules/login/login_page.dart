import 'package:delivery_backoffice_dw10/src/core/ui/helpers/loader.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/helpers/size_extensions.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/colors_app.dart';
import 'package:delivery_backoffice_dw10/src/core/ui/styles/text_styles.dart';
import 'package:delivery_backoffice_dw10/src/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<LoginController>();
  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction((_) => controller.status, (status) {
      switch (status) {
        case LoginStateStatus.initial:
          break;
        case LoginStateStatus.loading:
          showLoader();
          break;
        case LoginStateStatus.success:
          hideLoader();
          Modular.to.navigate('/');
          break;
        case LoginStateStatus.error:
          hideLoader();
          showError(controller.errorMessage ?? 'Erro');
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenShortesSide = context.screenShortestSide;
    final screenWidth = context.screenWidth;
    return Scaffold(
        backgroundColor: context.colors.black,
        body: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenShortesSide * .5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/lanche.png'),
                              fit: BoxFit.cover)),
                    )),
                Container(
                  width: screenShortesSide * .5,
                  padding: EdgeInsets.only(top: context.percentHeight(.10)),
                  child: Image.asset('assets/images/logo.png'),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        constraints: BoxConstraints(
                          maxWidth: context
                              .percentWidth(screenWidth < 1300 ? .7 : .3),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: .3,
                                  child: Image.asset('assets/images/logo.png'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Login',
                                      style: context.textStyles.textTitle,
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailEC,
                                  decoration: const InputDecoration(
                                      labelText: 'E-mail'),
                                  validator: Validatorless.multiple([
                                    Validatorless.required(
                                        'E-mail Obrigatório!'),
                                    Validatorless.email('E-mail inválido!'),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordEC,
                                  obscureText: true,
                                  decoration:
                                      const InputDecoration(labelText: 'Senha'),
                                  validator: Validatorless.multiple([
                                    Validatorless.required(
                                        'Senha Obrigatória!'),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          final formValid = formKey.currentState
                                                  ?.validate() ??
                                              false;
                                          if (formValid) {
                                            controller.login(
                                                emailEC.text, passwordEC.text);
                                          }
                                        },
                                        child: const Text('Entrar')))
                              ],
                            ),
                          ),
                        )))
              ],
            )));
  }
}
