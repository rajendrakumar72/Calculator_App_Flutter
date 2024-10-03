import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_calculator.dart';

class KeyBoardRow extends StatelessWidget {
  const KeyBoardRow({super.key, required this.keys});

  final List<String> keys;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: key == 'AC'
                      ? Colors.red
                      : key == 'C'
                          ? Colors.grey
                          : key == '%'
                              ? Colors.orange
                              : Colors.blue),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (key == 'AC') {
                      BlocProvider.of<CalculatorBloc>(context).add(AllClearPressed());
                    } else if (key == 'C') {
                      BlocProvider.of<CalculatorBloc>(context).add(ClearPressed());
                    } else if (key == '=') {
                      BlocProvider.of<CalculatorBloc>(context).add(EqualPressed());
                    } else {
                      BlocProvider.of<CalculatorBloc>(context).add(InputPressed(key));
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                    child: Text(
                      key,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
