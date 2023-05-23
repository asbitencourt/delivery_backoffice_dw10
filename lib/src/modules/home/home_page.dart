import 'package:delivery_backoffice_dw10/src/core/ui/helpers/messages.dart';
import 'package:delivery_backoffice_dw10/src/modules/template/base_layout.dart';

import 'package:flutter/material.dart';

import '../../core/ui/helpers/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        body: Container(
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                decoration: InputDecoration(label: Text('Login')),
                validator: (String) => 'Erro',
              ),
            ),
          ),
          SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Botão'),
              )),
        ],
      )),
    ));
  }
}
