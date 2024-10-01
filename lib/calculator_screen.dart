import 'package:calculator_app/calculator_view.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator App',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),backgroundColor: Colors.blue,),
      body: const CalculatorView(),
    );
  }
}
