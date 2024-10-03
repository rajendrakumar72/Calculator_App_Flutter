import 'package:calculator_app/keyboard_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_calculator.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
            flex: 2,
            child:Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<CalculatorBloc,String>(
                builder: (context,state){
                  print(state);
                  return Text(state,style: const TextStyle(fontSize: 48),);
                },
              ),
            ),
        ),
        Expanded(flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Column(
                children: [
                  KeyBoardRow(keys: ['C','AC','%','/']),
                  KeyBoardRow(keys: ['7','8','9','*']),
                  KeyBoardRow(keys: ['4','5','6','-']),
                  KeyBoardRow(keys: ['1','2','3','+']),
                  KeyBoardRow(keys: ['00','0','.','=']),
                ],
              ),
            ),
        ),
      ],
    );
  }
}
