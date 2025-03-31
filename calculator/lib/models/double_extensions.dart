extension DoubleExtensions on double {
  String toTrimmedString() {
    String result = toStringAsFixed(10);
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }
}
