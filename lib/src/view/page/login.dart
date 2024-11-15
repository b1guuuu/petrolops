import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/dao/user_dao.dart';
import 'package:petrolops/src/view/component/base_button.dart';
import 'package:petrolops/src/view/page/home.dart';
import 'package:petrolops/src/view/component/simple_form_container.dart';

class LoginPage extends StatefulWidget {
  static const route = '/';

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _documentTxtEdtController = TextEditingController();
  final _passwordTxtEdtController = TextEditingController();
  final _formLogin = GlobalKey<FormState>();

  Future<void> _login() async {
    try {
      var user = UserDao().users.firstWhere((u) =>
          u.registration == int.parse(_documentTxtEdtController.text) &&
          u.password == _passwordTxtEdtController.text);
      GlobalController.instance.setUser(user);
      Navigator.of(context).pushNamed(HomePage.route);
    } catch (e) {
      print('');
      print(e);
      print('');

      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Verifique a matrícula e senha informadas.',
          title: 'Credenciais inválidas',
          confirmBtnText: 'Fechar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        centerTitle: true,
        title: const Text('PETROLOPS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: SimpleFormContainer(
          numFieds: 2,
          child: Form(
              key: _formLogin,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(10, 166, 166, 166),
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      autocorrect: false,
                      controller: _documentTxtEdtController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text('Matrícula'),
                          hintText: 'Digite a sua matrícula...',
                          border: OutlineInputBorder()),
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a matrícula";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autocorrect: false,
                      controller: _passwordTxtEdtController,
                      decoration: const InputDecoration(
                          label: Text('Senha'),
                          hintText: 'Digite a sua senha...',
                          border: OutlineInputBorder()),
                      enableSuggestions: false,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe a senha";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    BaseButton(
                      onPressed: () {
                        if (_formLogin.currentState!.validate()) {
                          _login();
                        }
                      },
                      child: const Text('Entrar'),
                    )
                  ],
                ),
              ))),
    );
  }
}
