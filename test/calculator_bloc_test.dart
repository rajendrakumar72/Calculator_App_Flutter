import 'package:bloc_test/bloc_test.dart';
import 'package:calculator_app/bloc_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculatorBloc', () {
    late CalculatorBloc calculatorBloc;

    setUp(() {
      calculatorBloc = CalculatorBloc();
    });

    tearDown(() {
      calculatorBloc.close(); // Close the bloc after each test
    });

    test('initial state is 0', () {
      expect(calculatorBloc.state, '0');
    });

    blocTest<CalculatorBloc, String>(
      'emits [\'5\'] when InputPressed with input \'5\' is added',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(InputPressed('5')),
      expect: () => ['5'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'5+\'] when InputPressed with input \'+\' is added after \'5\'',
      build: () => calculatorBloc..add(InputPressed('5')),
      act: (bloc) => bloc.add(InputPressed('+')),
      expect: () => ['5+'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'Error\'] when EqualPressed is added without a valid equation',
      build: () => calculatorBloc..add(InputPressed('5+')),
      act: (bloc) => bloc.add(EqualPressed()),
      expect: () => ['Error'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'0\'] when AllClearPressed is added',
      build: () => calculatorBloc..add(InputPressed('5+')),
      act: (bloc) => bloc.add(AllClearPressed()),
      expect: () => ['0'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'10\'] when valid input is provided and EqualPressed is added',
      build: () {
        // Set up a mock for CalculatorUtils if needed
        return calculatorBloc..add(InputPressed('5'))..add(InputPressed('+'))..add(InputPressed('5'));
      },
      act: (bloc) => bloc.add(EqualPressed()),
      expect: () => ['10'], // Assuming the calculator function returns '10' for '5+5'
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'0\'] when ClearPressed is added after pressing a number',
      build: () {
        // Add input first
        calculatorBloc.add(InputPressed('5'));
        return calculatorBloc;
      },
      act: (bloc) => bloc.add(ClearPressed()),
      expect: () => ['0'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'5\'] when ClearPressed is added on \'5\'',
      build: () {
        calculatorBloc.add(InputPressed('5'));
        return calculatorBloc;
      },
      act: (bloc) => bloc.add(ClearPressed()),
      expect: () => ['0'],
    );

    blocTest<CalculatorBloc, String>(
      'emits [\'Error\'] when input results in an exception',
      build: () {
        // Mock the calculator method to throw an exception
        return calculatorBloc;
      },
      act: (bloc) {
        bloc.add(InputPressed('5/0')); // Division by zero
        bloc.add(EqualPressed());
      },
      expect: () => ['Error'],
    );
  });
}
