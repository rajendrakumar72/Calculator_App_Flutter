import 'package:flutter/material.dart';

import 'bloc_calculator.dart';

class KeyBoardRow extends StatelessWidget {
  const KeyBoardRow({super.key, required this.keys, required this.bloc});

  final List<String> keys;
  final CalculatorBloc bloc;

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
                      bloc.add(AllClearPressed());
                    } else if (key == 'C') {
                      bloc.add(ClearPressed());
                    } else if (key == '=') {
                      bloc.add(EqualPressed());
                    } else {
                      bloc.add(InputPressed(key));
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
