import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import './View/login.dart';

void main() {
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
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 195, 207),
          leading: Image(image: AssetImage('assets/images/nossa-marca.png')),
          centerTitle: true,
          title: const Text(
            "Login",
            style: TextStyle(
              color: Color.fromARGB(255, 10, 16, 83),
              fontWeight: FontWeight.bold,
              fontSize: 30
            )
          ),
        ),
        body: LoginScreen(),
        ),
      );
  }
}
