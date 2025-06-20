import 'package:yandex_school_finance/core/extensions/number_formatting.dart';
import 'package:yandex_school_finance/data/models/transaction_models/transaction_response_model.dart';

String sumOfTransactions(List<TransactionResponseModel> transactions) {
  final sum = transactions.fold<double>(
    0,
    (value, element) => value + element.amount.toDouble(),
  );
  return sum.formatWithSpaces();
}
