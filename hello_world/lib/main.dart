import 'package:flutter/material.dart';
import 'package:hello_world/states/LoginForm/main.dart';

class MyApp extends StatelessWidget {  
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Login',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulário de Login'),
        ),
        body: const LoginForm(),
      ),
    );
  }
}

main() {
  runApp(const MyApp());
}