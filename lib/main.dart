import 'package:flutter/material.dart';

void main() {
  runApp(FinancialApp());
}

class FinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial app',
      theme: ThemeData.dark(),
      home: Placeholder(),
    );
  }
}
