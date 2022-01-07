import 'package:cuidapet_app/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_app/app/core/ui/validators/validators.dart';
import 'package:cuidapet_app/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_app/app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'package:cuidapet_app/app/modules/auth/register/register_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final loginEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    loginEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 1.statusBarHeight + 30, left: 20, right: 20),
          width: 1.sw,
          height: 1.sh - 1.statusBarHeight - kToolbarHeight,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150.w,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                CuidapetTextFormField(
                  label: 'Login',
                  controller: loginEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Email obrigatório'),
                    Validatorless.email('Email inválido')
                  ]),
                ),
                const SizedBox(height: 10),
                CuidapetTextFormField(
                  label: 'Senha',
                  obscureText: true,
                  controller: passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatória'),
                    Validatorless.min(6, 'Mínimo 6 caracteres')
                  ]),
                ),
                const SizedBox(height: 10),
                CuidapetTextFormField(
                  label: 'Confirmar Senha',
                  obscureText: true,
                  controller: confirmPasswordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar senha obrigatória'),
                    Validatorless.min(6, 'Mínimo 6 caracteres'),
                    Validators.compare(
                        passwordEC, 'Senha e Confirmar Senha não são iguais'),
                  ]),
                ),
                const SizedBox(height: 10),
                CuidapetDefaultButton(
                  label: 'Cadastre-se',
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      controller.register(loginEC.text, passwordEC.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
