extension DateToString on DateTime {
  String toHumanString() {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/$year";
  }

  String toShortString() => "$day.$month.$year";
}
