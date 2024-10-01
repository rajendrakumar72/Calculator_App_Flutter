import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

// Events for CalculatorBloc
abstract class CalculatorEvent {}

class InputPressed extends CalculatorEvent {
  final String input;
  InputPressed(this.input);
}

class ClearPressed extends CalculatorEvent {
}

class AllClearPressed extends CalculatorEvent {
}

class EqualPressed extends CalculatorEvent {
}

// Bloc implementation
class CalculatorBloc extends Bloc<CalculatorEvent, String> {
  CalculatorBloc() : super('0') {
    // Registering event handlers
    on<InputPressed>((event, emit) {
      String currentValue = state;
      String input = event.input;

      if (currentValue == 'Error') {
        currentValue = '0';
      }

      if (input == 'C') {
        if (currentValue.length > 1) {
          emit(currentValue.substring(0, currentValue.length - 1));
        } else {
          emit('0');
        }
      } else if (input == 'AC') {
        emit('0');
      } else if (input == '=') {
        try {
          String result = _calculator(currentValue);
          emit(result);
        } catch (e) {
          emit('Error');
        }
      } else {
        if (currentValue == '0' && input != '.') {
          emit(input);
        } else {
          emit(currentValue + input);
        }
      }
    });

    on<ClearPressed>((event, emit) {
      String currentValue = state;
      if (currentValue.length > 1) {
        emit(currentValue.substring(0, currentValue.length - 1));
      } else {
        emit('0');
      }
    });

    on<AllClearPressed>((event, emit) {
      emit('0');
    });

    on<EqualPressed>((event, emit) {
      try {
        String result = _calculator(state);
        emit(result);
      } catch (e) {
        emit('Error');
      }
    });
  }

  // Function to evaluate mathematical expressions
  String _calculator(String expression) {
    expression = expression.replaceAll('%', '* 0.01');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  }
}
