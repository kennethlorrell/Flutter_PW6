import 'package:flutter/material.dart';
import 'pages/electric_load_calculator_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ElectricLoadCalculatorPage(),
    );
  }
}
