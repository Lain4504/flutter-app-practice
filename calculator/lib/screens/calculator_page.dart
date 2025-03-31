import 'package:flutter/material.dart';
import '../models/calculator.dart';
import '../models/double_extensions.dart';
import '../widgets/calc_button.dart';
import '../widgets/display.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String currentEntry = "";
  int currentState = 1;
  String? mathOperator;

  double firstNumber = 0, secondNumber = 0;
  String resultText = "0";

  void onSelectNumber(String number) {
    setState(() {
      if (resultText == "0") {
        resultText = number;
      } else {
        resultText += number;
      }
    });
  }

  void onSelectOperator(String operator) {
    setState(() {
      if (mathOperator != null) {
        secondNumber = double.parse(resultText);
        double result = Calculator.calculate(
          firstNumber,
          secondNumber,
          mathOperator!,
        );
        firstNumber = result;
        resultText = result.toTrimmedString();
      } else {
        firstNumber = double.parse(resultText);
      }
      mathOperator = operator;
      resultText = "0";
    });
  }

  void onCalculate() {
    if (mathOperator != null) {
      setState(() {
        secondNumber = double.parse(resultText);
        double result = Calculator.calculate(
          firstNumber,
          secondNumber,
          mathOperator!,
        );
        resultText = result.toTrimmedString();
        mathOperator = null;
        firstNumber = result;
      });
    }
  }

  void onClear() {
    setState(() {
      resultText = "0";
      firstNumber = 0;
      secondNumber = 0;
      mathOperator = null;
    });
  }

  void onToggleSign() {
    setState(() {
      if (resultText.startsWith('-')) {
        resultText = resultText.substring(1);
      } else {
        resultText = '-$resultText';
      }
    });
  }

  void onPercentage() {
    setState(() {
      double value = double.parse(resultText);
      resultText = (value / 100).toTrimmedString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Display(
            resultText: resultText,
            previousEntry: firstNumber != 0 ? firstNumber.toString() : null,
            operator: mathOperator,
          ),
          const SizedBox(height: 10),
          buildButtonRows(),
        ],
      ),
    );
  }

  Widget buildButtonRows() {
    return Column(
      children: [
        buildButtonRow(["C", "+/-", "%", "÷"]),
        buildButtonRow(["7", "8", "9", "×"]),
        buildButtonRow(["4", "5", "6", "-"]),
        buildButtonRow(["1", "2", "3", "+"]),
        buildButtonRow(["00", "0", ".", "="]),
      ],
    );
  }

  Widget buildButtonRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          values.map((value) {
            return CalcButton(
              label: value,
              onTap: () {
                if (value == "C") {
                  onClear();
                } else if (value == "=") {
                  onCalculate();
                } else if (value == "%") {
                  onPercentage();
                } else if (value == "+/-") {
                  onToggleSign();
                } else if (["÷", "×", "-", "+"].contains(value)) {
                  onSelectOperator(value);
                } else {
                  onSelectNumber(value);
                }
              },
            );
          }).toList(),
    );
  }
}
