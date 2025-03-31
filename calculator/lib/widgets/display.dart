import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String resultText;
  final String? previousEntry;
  final String? operator;

  const Display({
    super.key,
    required this.resultText,
    this.previousEntry,
    this.operator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (previousEntry != null && operator != null)
            Text(
              '$previousEntry $operator',
              style: const TextStyle(fontSize: 24, color: Colors.white70),
            ),
          Text(
            resultText,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
