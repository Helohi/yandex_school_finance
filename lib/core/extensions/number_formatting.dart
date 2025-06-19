extension NumberFormatting on double {
  String formatWithSpaces() {
    List<String> parts = toString().split('.');
    String integerPart = parts[0];
    String? fractionalPart = parts.length > 1 ? parts[1] : null;

    String formattedIntegerPart = "";
    int count = 0;
    for (int i = integerPart.length - 1; i >= 0; i--) {
      formattedIntegerPart = integerPart[i] + formattedIntegerPart;
      count++;
      if (count % 3 == 0 && i != 0) {
        formattedIntegerPart = ' $formattedIntegerPart';
      }
    }

    return '$formattedIntegerPart.$fractionalPart'.replaceAll(
      RegExp(r"([.]*0+)(?!.*\d)"),
      "",
    );
  }
}
