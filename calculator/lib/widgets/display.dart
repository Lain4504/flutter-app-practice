import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String resultText;
  const Display ({
    super.key,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Text(
        resultText,
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

}