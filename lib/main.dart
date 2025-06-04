import 'package:flutter/material.dart';
import 'package:teste/app.dart';

/// Função principal que inicializa o aplicativo Flutter.
void main() {
  runApp(const MyApp());
}

/// Widget raiz do aplicativo.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Pet - PluriTech',
      home: App(),
    );
  }
}
