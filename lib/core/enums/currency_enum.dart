// ignore_for_file: constant_identifier_names

enum CurrencyEnum {
  RUB("₽", "Российский рубль ₽"),
  USD("\$", "Американский доллар \$"),
  EUR("€", "Евро");

  const CurrencyEnum(this.symbol, this.fullName);
  final String symbol;
  final String fullName;
}
