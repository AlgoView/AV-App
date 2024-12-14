import 'package:alogoview_app/screens/terminal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlgoViewApp());
}

class AlgoViewApp extends StatelessWidget {
  const AlgoViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TerminalScreen(),
    );
  }
}