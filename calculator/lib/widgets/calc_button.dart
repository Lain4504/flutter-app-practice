import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CalcButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: _getButtonColor(label),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String label) {
    if (label == "C") return Colors.red;
    if (["÷", "×", "-", "+"].contains(label)) return Colors.orange;
    if (label == "=") return Colors.green;
    return Colors.grey[800]!;
  }
}
