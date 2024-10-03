class CalculatorUtils{
  static String calculator(String expression) {
    try {
      expression = expression.replaceAll('%', '* 0.01');
      List<String> tokens = _tokenize(expression);
      double result = _evaluate(tokens);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

// Tokenize the input string
 static List<String> _tokenize(String expression) {
    List<String> tokens = [];
    String number = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if ('0123456789.'.contains(char)) {
        number += char;  // Keep building the number
      } else if ('+-*/'.contains(char)) {
        if (number.isNotEmpty) {
          tokens.add(number);  // Add the number
          number = '';
        }
        tokens.add(char);  // Add the operator
      }
    }

    if (number.isNotEmpty) {
      tokens.add(number);  // Add the last number
    }

    return tokens;
  }

// Evaluate the tokenized expression (handle order of operations)
  static double _evaluate(List<String> tokens) {
    // Step 1: Handle multiplication and division
    List<String> intermediateTokens = [];
    double currentValue;

    for (int i = 0; i < tokens.length; i++) {
      String token = tokens[i];

      if (token == '*' || token == '/') {
        double left = double.parse(intermediateTokens.removeLast());
        double right = double.parse(tokens[++i]);
        currentValue = (token == '*') ? left * right : left / right;
        intermediateTokens.add(currentValue.toString());
      } else {
        intermediateTokens.add(token);  // Keep for addition and subtraction
      }
    }

    // Step 2: Handle addition and subtraction
    currentValue = double.parse(intermediateTokens[0]);
    for (int i = 1; i < intermediateTokens.length; i += 2) {
      String operator = intermediateTokens[i];
      double nextValue = double.parse(intermediateTokens[i + 1]);

      if (operator == '+') {
        currentValue += nextValue;
      } else if (operator == '-') {
        currentValue -= nextValue;
      }
    }

    return currentValue;
  }

}