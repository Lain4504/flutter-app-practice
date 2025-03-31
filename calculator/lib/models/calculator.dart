class Calculator {
  static double calculate(double value1, double value2, String operator) {
      switch (operator) {
        case '+':
          return value1 + value2;
        case '-':
          return value1 - value2;
        case '*':
          return value1 * value2;
        case '/':
          return value1 / value2;
        default:
          return 0;
      }
  }
}