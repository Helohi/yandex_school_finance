import 'package:alchemist/alchemist.dart';
import 'package:flutter/rendering.dart';
import 'package:yandex_school_finance/presentation/widgets/transaction_tile.dart';

void main() {
  goldenTest(
    "TransactionTile",
    fileName: "transaction_tile",
    builder: () => GoldenTestGroup(
      scenarioConstraints: const BoxConstraints(maxWidth: 600),
      children: [
        GoldenTestScenario(
          name: "renders correctly with name and amount",
          child: const TransactionTile(
            transactionCategoryName: "Category Name",
            transactionAmount: "1000 ₽",
          ),
        ),
      ],
    ),
  );
}
