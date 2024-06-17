import 'package:app_odonto/View/cadastro.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_odonto/View/esqueceu_senha.dart';
import 'package:app_odonto/View/menu.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import './View/login.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Odonto Helper",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'Login',
      routes: {
        'Login': (context) => const LoginScreen(),
        'Cadastro': (context) => const CadastroScreen(),
        'EsqueceuSenha': (context) => const EsqueceuSenhaScreen(),
        'Menu': (context) => const MenuScreen(),
      },
    );
  }
}
