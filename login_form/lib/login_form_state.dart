import 'package:flutter/material.dart';
import 'package:login_form/login_form.dart';

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Digite seu email'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email é obrigatório.';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Digite sua senha'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Senha é obrigatória.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processando dados...'))
                  );
                }
              },
              child: const Text('Entrar')
            ),
          ),
        ],
      ),
    );
  }
}